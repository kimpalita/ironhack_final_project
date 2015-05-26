// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function(){
	$(function () {
  		$('[data-toggle="tooltip"]').tooltip()
	});


	$('.like-button').click(function() { 
			console.log("LIKED!!!")
			$('.dislike-button').remove();
			$(this).addClass('disabled');
	});

	$('.dislike-button').click(function() { 
			console.log("DISLIKED!!!")
			$('.like-button').remove();
			$(this).addClass('disabled');
	});
}

$(document).ready(ready);
	










