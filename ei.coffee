#
# Environment Indicator JS-code.
#
# @author Vasily Gudoshnikov
# @author Alexander Shvets
#
# @see https://drupal.org/project/environment_indicator
#

jQuery ->
    $ = jQuery
    # Initialize settings.
    window.environmentIndicator = $.extend({
        text: ' ',
        color: '#006400',
        position: 'left',
        ul_enabled: true,
        users: '',
        assetsPath: '/'
    }, window.environmentIndicator)

    eiSettings = window.environmentIndicator

    if $('body:not(.environment-indicator-processed)').length
        eiSettings.cssClass = 'environment-indicator-' + eiSettings.position

        # If we don't have an environment indicator, inject it into the document.
        unless $('#environment-indicator').length
            $('body').prepend('<div id="environment-indicator">' + eiSettings.text + '</div>')
            $('body').addClass(eiSettings.cssClass)

            # Set the colour.
            $environmentIndicator = $('#environment-indicator')
            $environmentIndicator.css('background-color', eiSettings.color)

            # Make the text appear vertically
            $environmentIndicator.html('<div style="margin-top:100px">' + $environmentIndicator.text().replace(/(.)/g,"$1<br />") + '</div>')

            # Switch button and user list.
            if eiSettings.ul_enabled and eiSettings.users

                # Add environment for switch button and user list.
                $user_list = """
                            <div id="ei-ul-wrapper">
                              <div id="ei-ul-button">
                              </div>
                              <div id="ei-ul-inner-wrapper">
                                <div id="ei-ul-arrow">
                                </div>
                                <div id="ei-ul-list-wrapper">
                                  <div id="ei-ul-border">
                                    <div id="ei-ul-bg">
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            """
                $environmentIndicator.html($user_list + $environmentIndicator.html())
                $('#ei-ul-button').attr('title', 'Click to show users list.')

                # Load user list.
                $('#ei-ul-bg').html('<div id="ei-ul-login">' + 'Login as:' + '</div><ul>' + eiSettings.users + '</ul>')

                # Set backgrounds.
                $('#ei-ul-button').css('background-image', 'url(\'' + eiSettings.assetsPath + '/lock-button.png\')')
                $('#ei-ul-border').css('background-image', 'url(\'' + eiSettings.assetsPath + '/transparent.png\')')
                $('#ei-ul-list-wrapper').css('background-color', eiSettings.color)
                $('#ei-ul-bg').css('background-color', eiSettings.color)

                timeout = null
                onTimeout = () ->
                    jQuery('#ei-ul-inner-wrapper').removeClass('ei-ul-inner-wrapper-visible')
                    jQuery('#ei-ul-button').removeClass('ei-ul-button-pushed')

                # Button click.
                $('#ei-ul-button').click () ->
                    $('#ei-ul-inner-wrapper').toggleClass('ei-ul-inner-wrapper-visible')
                    $('#ei-ul-button').toggleClass('ei-ul-button-pushed')
                    if $('#ei-ul-button').hasClass('ei-ul-button-pushed')
                        timeout = setTimeout(onTimeout, 5000)

                # Link hover.
                linkHoverIn = () -> $(this).parent().css('background-image', 'url(\'' + eiSettings.assetsPath + '/transparent.png\')')
                linkHoverOut = () -> $(this).parent().css('background-image', 'none')
                $("#ei-ul-list-wrapper ul li a").hover(linkHoverIn, linkHoverOut)

                # List hover.
                listHoverIn = () -> if timeout then clearTimeout timeout
                listHoverOut = () -> timeout = setTimeout(onTimeout, 2000)
                $('#ei-ul-list-wrapper').hover(listHoverIn, listHoverOut)

                if eiSettings.position is 'left'
                    $('#ei-ul-inner-wrapper').addClass('ei-ul-inner-wrapper-left')
                    $('#ei-ul-arrow').addClass('ei-ul-arrow-left')
                    $('#ei-ul-arrow').css('border-right', '12px solid ' + eiSettings.color)
                else
                    $('#ei-ul-inner-wrapper').addClass('ei-ul-inner-wrapper-right')
                    $('#ei-ul-arrow').addClass('ei-ul-arrow-right')
                    $('#ei-ul-arrow').css('border-left', '12px solid ' + eiSettings.color)

        $('body:not(.environment-indicator-processed)').addClass('environment-indicator-processed')

