
$(document).on('turbolinks:load', function() {
  
  if($('.editor_index').length > 0){
    GistsIndexEditorsInit();
  }
  if($('.editor_show').length > 0){
    GistShowEditorsInit();
  }
  if($('.editor__form').length > 0){
    GistEditEditorInit();
  }

});

function GistsIndexEditorsInit() {
  
  var editors = document.querySelectorAll('[id^="editor_"]');
  
  for (var i = 0; i < editors.length; i++) {
    var editor = ace.edit(editors[i].id, {
      readOnly: true,
      theme: "ace/theme/tomorrow_night_blue",
      mode: "ace/mode/html",
      autoScrollEditorIntoView: true,
      maxLines: 30,
      minLines: 5
    });
    editor.setShowPrintMargin(false);
    editor.setValue(document.getElementById("text_" + editors[i].id).value, -1);
  }
}

function GistEditEditorInit() {
  
  var editor = ace.edit("editor", {
    theme: "ace/theme/tomorrow_night_blue",
    mode: "ace/mode/html",
    autoScrollEditorIntoView: true,
    maxLines: 30,
    minLines: 10
  });
  editor.setShowPrintMargin(false);
  editor.setValue(document.getElementById("gist_text").value, -1);
  
  editor.on("change", function () {
    document.getElementById("gist_text").value = editor.getValue()
  });
}

function GistShowEditorsInit() {
  var editor = ace.edit("editor", {
    readOnly: true,
    theme: "ace/theme/tomorrow_night_blue",
    mode: "ace/mode/html",
    autoScrollEditorIntoView: true,
    maxLines: 30,
    minLines: 10
  });
  editor.setShowPrintMargin(false);
  editor.setValue(document.getElementById("text_editor").value, -1);

  var editorcomments = document.querySelectorAll('[id^="editorcomment_"]');

  for (var i = 0; i < editorcomments.length; i++) {
    var editor = ace.edit(editorcomments[i].id, {
      readOnly: true,
      theme: "ace/theme/crimson_editor",
      mode: "ace/mode/html",
      autoScrollEditorIntoView: true,
      maxLines: 30,
      minLines: 2
    });
    editor.setShowPrintMargin(false);
    editor.setValue(document.getElementById("text_" + editorcomments[i].id).value, -1);
  }
}

