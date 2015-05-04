function hackyGrab() {
    var $itemList = $("#detail-info > h3");
    var currentIndex = -1;
    var emailList = [];

    function hasMailLink($elem) {
        var attr = $(this).attr("href");

        return attr != null && attr.match(/^mailto:/) != null;
    }

    function grabOne() {
        if (currentIndex >= $itemList.length) {
            console.log(emailList);

            clearInterval(intervalID);

            return;
        }

        if (currentIndex >= 0) {
            $(".innerWindow p > a").filter(hasMailLink).each(function() {
                emailList.push($(this).attr("href").substring(7));
            });
        }

        $($itemList[++currentIndex]).trigger('click');
    }

    var intervalID = setInterval(grabOne, 1000);
}

hackyGrab();
