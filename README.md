yii-environment-indicator
=========================

Adds a colored strip to the side of the site informing the user which environment they are in (development, staging, production etc).
Also adds ability to switch current user in two clicks.


## Usage

Without user switcher:

    void($this->widget('ext.environmentindicator.ei', array(
        'text' => 'DEV ENVIRONMENT'
    )));

With user switcher:

    void($this->widget('ext.environmentindicator.ei', array(
        'text' => 'DEV ENVIRONMENT',
        'users' => array(
            1 => 'User1',
            2 => 'User2',
            3 => 'User3'
        ),
        'userSwitchUrl' => '/user/switch'
    )));

In last case you should manually define handler for the path specified in "userSwitchUrl"