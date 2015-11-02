#!/usr/bin/env coffee

Fs = require "fs"
AppcastXML = require "./AppcastXML.coffee"

appcast = new AppcastXML
    declaration: true
    indent: "\t"

appcast.setChannelConfiguration
    title: "KeepingYouAwake Changelog"
    link: "https://newmarcel.github.io/KeepingYouAwake/appcast.xml"
    description: "The most recent changes for KeepingYouAwake."

# Version 1.3
appcast.addItem
    title: "Version 1.3: Scripting and Custom Icons Update"
    description: '''
    <ul>
    <li>Basic command line interface through URI schemes

        <ul>
            <li><em>Thank you <a href="https://github.com/KyleKing">KyleKing</a> for the suggestion!</em></li>
            <li>you can activate/deactivate the sleep timer with unlimited time intervals</li>
            <li>you can open <em>KeepingYouAwake</em> from the command line with a custom sleep timer duration</li>
            <li>the <em>seconds</em>, <em>minutes</em> and <em>hours</em> parameters are rounded up to the nearest integer number and cannot be combined at the moment</li>
        </ul>

        <p>open keepingyouawake://<br/>
        open keepingyouawake:///activate # indefinite duration<br/>
        open keepingyouawake:///activate?seconds=5<br/>
        open keepingyouawake:///activate?minutes=5<br/>
        open keepingyouawake:///activate?hours=5<br/>
        open keepingyouawake:///deactivate</p></li>
    <li><p>Support for custom menu bar icons. Just place four images named <code>ActiveIcon.png</code>, <code>ActiveIcon@2x.png</code>, <code>InactiveIcon.png</code>, <code>InactiveIcon@2x.png</code> in your <code>~/Library/Application Support/KeepingYouAwake/</code> folder. The recommended size for these images is 22x20 pts</p></li>
    <li><p>hold down the option key and click inside the <em>&#8220;Activate for Duration&#8221;</em> menu to set the default duration for the menu bar icon</p></li>
    </ul>
    '''
    date: new Date("2015-11-02 10:00:00")
    file_url: 'https://github.com/newmarcel/KeepingYouAwake/releases/download/1.3/KeepingYouAwake-1.3.zip'
    file_length: 1483228
    file_version: '130'
    file_short_version: '1.3'

# Version 1.2.1
appcast.addItem
    title: "Version 1.2.1: AC Power Update"
    description: '''
    <ul>
    <li><p>Fixed an issue where &#8220;Start at Login&#8221; would crash when clicked multiple times in a row <em>(Fixed by <a href="https://github.com/registered99">registered99</a>, thank you!)</em></p></li>
    <li><p>Less aggressive awake handling when the MacBook lid is closed by using the <code>caffeinate -di</code> command instead of <code>caffeinate -disu</code></p></li>
    <li><p>You can revert back to the previous behaviour by pasting the following snippet into <em>Terminal.app</em>:</p>

    <pre><code>defaults write info.marcel-dierkes.KeepingYouAwake.PreventSleepOnACPower -bool YES
    </code></pre></li>
    <li><p><code>ctrl</code> + <code>click</code> will now display the menu</p></li>
    </ul>
    '''
    date: new Date("2015-01-11 20:20:00")
    file_url: 'https://github.com/newmarcel/KeepingYouAwake/releases/download/1.2.1/KeepingYouAwake-1.2.1.zip'
    file_length: 1482545
    file_version: '122'
    file_short_version: '1.2.1'

# Version 1.2
appcast.addItem
    title: "Version 1.2: Activation Timer"
    description: '''
    <ul>
        <li>There are no significant changes since beta1</li>
        <li>Tweaked the experimental <em>(and hidden)</em> notifications</li>
        <li>You can enable the notifications preview by pasting the following snippet into <em>Terminal.app</em>:<br />
            <pre><code>defaults write info.marcel-dierkes.KeepingYouAwake info.marcel-dierkes.KeepingYouAwake.NotificationsEnabled -bool YES</code></pre>
        </li>
        <li>and to disable it again:<br />
            <pre><code>defaults write info.marcel-dierkes.KeepingYouAwake info.marcel-dierkes.KeepingYouAwake.NotificationsEnabled -bool NO
        </code></pre>
        </li>
    </ul>
    '''
    date: new Date("2014-11-23 11:00:00")
    file_url: 'https://github.com/newmarcel/KeepingYouAwake/releases/download/1.2/KeepingYouAwake-1.2.zip'
    file_length: 1516803
    file_version: '120'
    file_short_version: '1.2'

# Version 1.2beta1
appcast.addItem
    title: "Version 1.2beta1: Activation Timer"
    description: '''
    <ul>
        <li>Activation timer</li>
        <li><a href="http://sparkle-project.org">Sparkle</a> integration for updates
            <ul>
                <li>Sparkle will check for updates once a day</li>
                <li>A second beta will follow in the coming days to test automatic updates</li>
            </ul>
        </li>
        <li>This is <strong>beta</strong> software. If you notice any issues, please report them <a href="https://github.com/newmarcel/KeepingYouAwake/issues/">here</a></li>
    </ul>
    '''
    date: new Date("2014-11-13 19:00:00")
    file_url: 'https://github.com/newmarcel/KeepingYouAwake/releases/download/1.2beta1/KeepingYouAwake-1.2beta1.zip'
    file_length: 1512924
    file_version: '112'
    file_short_version: '1.2beta1'

# Version 1.1
appcast.addItem
    title: "Version 1.1: Start at Login & Developer ID"
    description: '''
    <p>This release adds a "Start at Login" menu item.</p>
    <ul>
        <li>Added Developer ID signing</li>
    </ul>
    '''
    date: new Date("2014-11-13 11:11:00")
    file_url: 'https://github.com/newmarcel/KeepingYouAwake/releases/download/1.1/KeepingYouAwake-1.1.zip'
    file_length: 357603
    file_version: '110'
    file_short_version: '1.1'


Fs.writeFile 'appcast.xml', appcast.toString(), (error) =>
    throw error if error
    console.log "appcast.xml saved."
