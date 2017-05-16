//= require jquery-fileupload/basic-plus
//= require sortable-rails-jquery

initializeMediumCollection = function(root) {
  $root = $(root);

  $root.find(".medium-collection-file-upload").each(function(index, element) {
    var $input = $(element);
    var $form = $input.closest("form");
    var $mediumCollection = $input.closest(".medium-collection-form");
    var $filesContainer = $mediumCollection.find(".files-container");

    var url = $mediumCollection.data("create-url");
    var fieldName = $mediumCollection.data('field-name');
    var template = $mediumCollection.data('template');
    var dropZone = $mediumCollection;

    $input.fileupload({
      limitConcurrentUploads: 5,
      url: url,
      type: 'POST',
      formData: {
        field_name: fieldName,
      },
      dropZone: dropZone,
      uploadTemplateId: null,
      downloadTemplateId: null,
      add: function(e, data) {
        var $filesContainer = $(this).closest(".medium-collection-form").find(".files-container");

        var $element = $(template);
        $element.find(".cancel-medium-upload").on("click", function() {
          data.abort();
          data.context.remove();
        });

        var $img = $element.find(".preview img");

        var reader = new FileReader();
        reader.onload = function(e) {
          $img.attr('src', e.target.result);
        }
        reader.readAsDataURL(data.files[0]);

        $filesContainer.append($element);
        data.context = $element;
        data.submit();
      },
      progress: function(event, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        data.context.find(".progress-bar").css("width", progress + "%");
      },
      done: function(event, data) {
        var $parent = data.context.closest(".files-container");

        if (data.result) {
          result = JSON.parse(data.result)
          data.context.replaceWith($(result.files[0].template));
          $parent.find(".medium").each(function(index, element) {
            $(element).find(".medium-position").val(index);
          });
          data.context.remove();
        }
      },
    });

    dropZone.on("dragleave dragend drop", function() {
      dropZone.removeClass("dragover");
    });

    dropZone.on("dragover", function() {
      dropZone.addClass("dragover");
    });

    $filesContainer.sortable({
      onUpdate: function(event) {
        var items = [];

        $(event.item).closest(".files-container").find(".medium").each(function(index, element) {
          $(element).find(".medium-position").val(index);
        });
      },
    });
  });
};

$(document).on("turbolinks:load", function(e) {
  initializeMediumCollection(document);
});

$(document).on("blocks:add", function(e, block) {
  initializeMediumCollection(block);
});


$(document).on("click", ".remove-medium", function(e) {
  var $medium = $(this).closest(".medium");
  var $input = $medium.find(".destroy-medium");

  if ($input.val() == 'false') {
    $input.val(true);
    $medium.addClass("disabled");
  } else {
    $input.val(false);
    $medium.removeClass("disabled");
  }
});
