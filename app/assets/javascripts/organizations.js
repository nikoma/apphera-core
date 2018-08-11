// Validation
$(".organization-validation").validate({
	rules: {
		'organization[name]': {
			required: true
		}
	},
	messages: {
		'organization[name]': {
			required: "can't be blank"
		}
	}
})
