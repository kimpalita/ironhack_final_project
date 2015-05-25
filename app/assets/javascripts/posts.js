// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function(){
	$('.like-button').click(function() { 
			console.log("LIKED!!!")
	});

	$('.dislike-button').click(function() { 
			console.log("DISLIKED!!!")
	});
}

$(document).ready(ready);
	










