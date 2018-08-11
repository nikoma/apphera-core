jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
        channel: "ChatRoomsChannel"
        chat_room_id: messages.data('chat-room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append data['message']
        messages_to_bottom()

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

    $(document).ready ->
      $('#new_message').on 'keypress', (e) ->
        if e.which ==13
          text=$('.emojionearea-editor').html()
          text=text.replace(/&nbsp;/gi, " ")
          text=text.replace(/["/]/gi, '').replace(/<img alt=/gi,'').replace(/class=emojioneemoji src=https:cdnjs.cloudflare.comajaxlibsemojione2.1.4assets/gi,'')
          start = 0
          end = 0
          flag = 0
          ifs = []
          text = text.replace(/png/gi, '\\')
          i = 0
          while i < text.length
            if text[i] == '\\'
              flag++
              if flag == 1
                start = i
              if flag == 2
                end = i
                ifs.push text.substr(start, end - start)
                flag = 0
                start = end = 0
            i++
          j = 0
          while j < ifs.length
            text = text.replace(ifs[j], '')
            j++
          text = text.replace(/[`\\>]/gi, '')

          App.global_chat.send_message text, messages.data('chat-room-id')
    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false