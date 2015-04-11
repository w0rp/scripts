var text = "";

$($('.wikitable')[0]).find('tr').each(function() {
    var $tr = $(this);

    $tr.children().each(function(i) {
        if (i > 0) {
            text += ",";
        }

        var $node = $(this).clone();
        $node.find(".reference").remove();

        text += '"';
        text += $node.text().replace(/"/g, '""');
        text += '"';
    });

    text += "<br>";
});

window.open().document.write(text);
