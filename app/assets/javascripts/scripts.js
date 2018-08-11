if(document.getElementById('script_code1')){
	var editor = CodeMirror.fromTextArea(document.getElementById('script_code1'), {
	  lineNumbers: true,
	  matchBrackets: true,
	  styleActiveLine: true,
	  theme: "ambiance",
	  extraKeys: {"Ctrl-Space": "autocomplete"},
	  mode: {name: "javascript", globalVars: true}
	});
}
