//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap

function commentNew(id, gistId) {

  if (document.getElementById("li_new_comment_gist_" + gistId) != null) return;

  var li = document.createElement("li");
  li.id = "li_new_comment_gist_" + gistId;
  li.className = "list-group-item";
 
  document.getElementById("comments_gist_" + gistId).appendChild(li);
  
  var newCommentValue = document.createElement("input");
  newCommentValue.type = "hidden";
  newCommentValue.id = "new_comment_value_gist_" + gistId;
  li.appendChild(newCommentValue);  
  
  var div = document.createElement("div");
  div.id = "new_comment_gist_" + gistId;
  
  li.appendChild(div);

  var buttonCommentCreate = document.createElement("input");
  buttonCommentCreate.type = "button"
  buttonCommentCreate.id = "btn_create_comment_gist_" + gistId;
  buttonCommentCreate.value = "Comment save";
  buttonCommentCreate.onclick = function() { commentCreate(gistId) };
  li.appendChild(buttonCommentCreate);
  
  var buttonCommentCancelling = document.createElement("input");
  buttonCommentCancelling.type = "button"
  buttonCommentCancelling.id = "btn_cancelling_comment_gist_" + gistId;
  buttonCommentCancelling.value = "Back";
  buttonCommentCancelling.onclick = function() { commentCancelling(gistId) };
  li.appendChild(buttonCommentCancelling);
  
  
  var editor = ace.edit(div.id, {
    theme: "ace/theme/crimson_editor",
    mode: "ace/mode/html",
    autoScrollEditorIntoView: true,
    maxLines: 30,
    minLines: 5
  });
  editor.setShowPrintMargin(false);
  editor.on("change", function () {
    document.getElementById("new_comment_value_gist_" + gistId).value = editor.getValue()
  });
}

function commentCreate(gistId) {

  var comment = document.getElementById("new_comment_value_gist_" + gistId).value;
  
  var parse_result;
  $.ajax({
    type: "POST",
    url: "/comments",
    dataType: "json",
    data: { gist_id: gistId, comment: comment },
    success: function(result) {
      
      var li = document.createElement("li");
      li.id = "comment_" + result.comment.id;
      li.className = "list-group-item";
     
      document.getElementById("comments_gist_" + gistId).appendChild(li);
      
      var div = document.createElement("div");
      div.align = "right";
      div.innerHTML = result.user_email;
      
      li.appendChild(div);
      
      var commentText = document.createElement("input");
      commentText.type = "hidden";
      commentText.id = "text_editorcomment_" + result.comment.id;
      commentText.value = result.comment.text;
      li.appendChild(commentText);  
  
      var divE = document.createElement("div");
      divE.id = "editorcomment_" + result.comment.id;
      
      li.appendChild(divE);
        
      var editor = ace.edit(divE.id, {
        readOnly: true,
        theme: "ace/theme/crimson_editor",
        mode: "ace/mode/html",
        autoScrollEditorIntoView: true,
        maxLines: 30,
        minLines: 2
      });
  
      editor.setValue(document.getElementById("text_editorcomment_" + result.comment.id).value, -1);
      document.getElementById("comments_gist_" + gistId).removeChild(document.getElementById("li_new_comment_gist_" + gistId));
      
      return false;
    },
    error: function() {
      return false;
    }
  });

}


function commentCancelling(gistId) {

  document.getElementById("comments_gist_" + gistId).removeChild(document.getElementById("li_new_comment_gist_" + gistId));
      
}