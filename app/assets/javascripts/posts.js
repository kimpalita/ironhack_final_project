// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function(){
	$(function () {
  		$('[data-toggle="tooltip"]').tooltip()
	});

	function addOne() {
        var number  =   parseInt($('.like-counter').html());
        return number + 1;
	}

	$('.like-button').click(function() { 
			console.log("LIKED!!!")
			$('.dislike-button').remove();
			$(this).addClass('disabled');
			$('.like-counter').text(addOne());
	});

	$('.dislike-button').click(function() { 
			console.log("DISLIKED!!!")
			$('.like-button').remove();
			$(this).addClass('disabled');
			$('.dislike-counter').text(addOne());
	});
}

$(document).ready(ready);
	










