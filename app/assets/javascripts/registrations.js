// Sign up Form Validation
// Validation

$("#new_user").validate({
	rules: {
		'user[organization_attributes][name]': {
			required: true
		},
		'user[email]': {
			required: true,
			email: true
		},
		'user[password]': {
			required: true
		},
		'user[password_confirmation]': {
			required: true,
			equalTo: '#user_password'
		}
	},
	messages: {
		'user[organization_attributes][name]': {
			required: "Name can't be blank"
		},
		'user[email]':{
			required: "can't be blank",
			email: 'Enter a valid email address'
		},
		'user[password_confirmation]': {
			required: "Password can't be blank"
		},
		'user[password]': {
			required: "Password can't be blank"
		}
	}
})
