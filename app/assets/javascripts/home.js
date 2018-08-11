// Sign up Form Validation
// Validation
$( document ).on('turbolinks:load', function() {
	$(".contact-form").validate({
		rules: {
			'contact[name]': {
				required: true
			},
			'contact[email]': {
				required: true,
				email: true
			},
			'contact[subject]': {
				required: true
			},
			'contact[message]': {
				required: true
			}
		},
		messages: {
			'contact[name]': {
				required: "Name can't be blank"
			},
			'contact[email]':{
				required: "can't be blank",
				email: 'Enter a valid email address'
			},
			'contact[subject]': {
				required: "Subject can't be blank"
			},
			'contact[message]': {
				required: "Message can't be blank"
			}
		}
	})
})
