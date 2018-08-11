// Sign up Form Validation
// Validation

$(".company-signup").validate({
	rules: {
		'user[company_attributes][name]': {
			required: true
		},
		'user[email]': {
			required: true,
			email: true
		},
		'user[password]': {
			required: true,
			minlength: 6
		},
		'user[password_confirmation]': {
			required: true,
			minlength: 6,
			equalTo: '#user_password'
		}
	},
	messages: {
		'user[company_attributes][name]': {
			required: "Name can't be blank"
		},
		'user[email]':{
			required: "can't be blank",
			email: 'Enter a valid email address'
		},
		'user[password_confirmation]': {
			required: "Password Confirmation can't be blank"
		},
		'user[password]': {
			required: "Password can't be blank"
		}
	}
})

$(".company-validation").validate({
	rules:{
		'company[name]': {
			required: true
		}
	},
	messages: {
		'company[name]': {
			required: "Name can't be blank !"
		}
	}
})