createBlockButtons = function()  {
  $(".block-buttons button").each(function(index, button) {
    $(button).off("click");

    $(button).on("click", function(e) {
      e.preventDefault();
      appendBlockForm(button, { scrollTo: true });
    });
  });
};

generateBlockForm = function(button) {
  var $button = $(button);
  var formData = $button.data("form");
  var blocksCount = $(".block-form").length;

  formData = formData.replace(/\[__.+?__\]/g, "[" + blocksCount + "]");
  formData = formData.replace(/___NEW__.+?___/g, "_" + blocksCount + "_");

  return $("<div class='block-form panel panel-primary'>" + formData + "</div>");
};

appendBlockForm = function(button, options) {
  $newBlock = generateBlockForm(button);
  $(".block-forms").append($newBlock);

  if (options !== undefined && options["scrollTo"]) {
    $(document).scrollTo($newBlock, { offset: $newBlock.outerHeight(), duration: 500 });
  }

  $(document).trigger("blocks:add", $newBlock);
  updateBlockFormPositions();
};

updateBlockFormPositions = function() {
  $(".block-form").each(function(index, form) {
    var $form = $(form);
    var $tinymce = $form.find(".tinymce");

    if ($tinymce) {
      $tinymce.each(function(index, element) {
        $element = $(element);
        tinyMCE.execCommand("mceRemoveEditor", false, $element.attr("id"));
        tinyMCE.execCommand("mceAddEditor", false, $element.attr("id"));
      });
    }

    $form.find(".block-position").val(index);
  });
};

createSortable = function() {
  $(".block-buttons").sortable({
    group: {
      name: "forms",
      pull: 'clone',
      put: false,
    },
    sort: false,
    animation: 150,
  });

  $(".block-forms").sortable({
    group: {
      name: "forms",
      pull: true,
      put: true,
    },
    sort: true,
    handle: ".handler",
    draggable: ".block-form",
    ghostClass: ".sortable-ghost",
    animation: 150,
    onUpdate: updateBlockFormPositions,
    onAdd: function(event) {
      $newBlock = generateBlockForm(event.clone);
      $(event.item).replaceWith($newBlock);
      $(document).trigger("blocks:add", $newBlock);
      updateBlockFormPositions();
    }
  });
};

$(document).on('turbolinks:request-end', function() {
  if (tinyMCE) { tinyMCE.remove(); }
});

$(document).on("turbolinks:load", function(e) {
  createSortable();
  createBlockButtons();

  $(".block-buttons").affix();
});

$(document).on("blocks:add", function(e, block) {
  var $textArea = $(block).find(".tinymce");
  tinyMCE.execCommand("mceAddEditor", false, $textArea.attr("id"));
  createSortable();
});

$(document).on('ready', function() {
  createSortable();
  createBlockButtons();

  $(document).on("click", ".remove-block-form-button", function(e) {
    e.preventDefault();
    $blockForm = $(this).closest(".block-form");

    if ($blockForm.hasClass("block-deleted")) {
      $blockForm.removeClass("block-deleted");
      $blockForm.find(".block-destroy").val(false);
    } else {
      $blockForm.addClass("block-deleted");
      $blockForm.find(".block-destroy").val(true);
    }
  });

  $(document).on("click", ".collapse-block-form-buttom", function(e) {
    e.preventDefault();
    $blockFormBody = $(this).closest(".block-form").find(".panel-body");
    $blockFormBody.collapse('toggle');
  });
});
