function update_app_id(app_id, controller_name){
  $.ajax({
    url: '/' + controller_name + '/update_all',
    dataType: 'script',
    method: 'put',
    data: {
      app_id: app_id
    }
  })
}
function search_app_id(app_id, controller_name){
  // $.ajax({
  //   url: '/' + controller_name + '/?app_id='+ app_id,
  //   dataType: 'script',
  //   method: 'get'
  // })
  window.location.href = location.origin + location.pathname +'?app_id='+app_id
}