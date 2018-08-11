require 'facebook/messenger'
include Facebook::Messenger


Facebook::Messenger::Bot.deliver({
                            recipient: {
                              id: '2156845181023970'
                            },
                            message: {
                              attachment: {
                                type: 'template',
                                payload: {
                                  template_type: 'button',
                                  text: 'Imagine a guy comes into the office and wants to stick his USB stick into your notebook?',
                                  buttons: [
                                    { type: 'postback', title: 'I kick his butt', payload: 'a' },
                                    { type: 'postback', title: 'I do it', payload: 'b' }, { type: 'postback', title: 'Was ist los? I will scream!', payload: 'c' }
                                  ]
                                }
                              }                            },
                            message_type: Facebook::Messenger
                          }, access_token: "EAAclLxe8sKII8lCnxwdNvAZBqswuYiQoHCL6ZCQs

                       #   https://en.wikipedia.org/wiki/Pig#/media/File:Sus_Barbatus,_the_Bornean_Bearded_Pig_(12616351323).jpg
