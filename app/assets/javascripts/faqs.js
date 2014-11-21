$(document).ready(function(){    

function toggleChevron(e) {
    $(e.target)
        .prev('.panel-heading')
        .find("i.fa")
        .toggleClass('fa-plus fa-minus');
}

$('.panel-collapse').on('hidden.bs.collapse', toggleChevron);
$('.panel-collapse').on('shown.bs.collapse', toggleChevron);

});