
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
    if($('.editor_comment').length > 0){
    CommentNewEditorInit();
  }  
});

function GistsIndexEditorsInit() {
  
  var editors = document.querySelectorAll('[id^="editor_"]');
  
  for (var i = 0; i < editors.length; i++) {
    var editor = setEditor(editors[i].id, 5);
    editor.setValue(document.getElementById("text_" + editors[i].id).value, -1);
  }
}

function GistEditEditorInit() {
  
  var editor = setEditor("editor", 10, false);
  editor.setValue(document.getElementById("gist_text").value, -1);
  
  editor.on("change", function () {
    document.getElementById("gist_text").value = editor.getValue()
  });
}

function GistShowEditorsInit() {
  
  var editor = setEditor("editor");
  editor.setValue(document.getElementById("text_editor").value, -1);

  var editor_comments = document.querySelectorAll('[id^="editor_comment_"]');

  for (var i = 0; i < editor_comments.length; i++) {
    var editor_comment = setEditor(editor_comments[i].id, 2, true, "ace/theme/crimson_editor");
    editor_comment.setValue(document.getElementById("text_" + editor_comments[i].id).value, -1);
  }
}

function CommentNewEditorInit() {
  
  var editor = setEditor("editor_comment", 10, false, "ace/theme/crimson_editor");
  editor.setValue(document.getElementById("comment_text").value, -1);
  
  editor.on("change", function () {
    document.getElementById("comment_text").value = editor.getValue()
  });
}

function setEditor(id, min_lines = 10, read_only = true, theme = "ace/theme/tomorrow_night_blue") {
  var editor = ace.edit(id, {
      readOnly: read_only,
      theme: theme,
      mode: "ace/mode/html",
      autoScrollEditorIntoView: true,
      maxLines: 30,
      minLines: min_lines
    });
    editor.setShowPrintMargin(false); 
  return editor;
}