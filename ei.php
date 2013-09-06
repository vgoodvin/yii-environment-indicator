<?php
/**
 * Environment Indicator
 *
 * Adds a coloured strip to the side of the site informing the user
 * which environment they are in (Development, Staging Production etc).
 * Adds ability to switch current user.
 *
 * @author Vasily Gudoshnikov
 * @author Alexander Shvets
 *
 * @see https://drupal.org/project/environment_indicator
 */
class ei extends CWidget
{
    public $color = '#006400';
    public $text = 'ENVIRONMENT INDICATOR';
    public $position = 'left';
    public $users = array();
    public $userSwitchUrl = '';

    public function run()
    {
        $css = Yii::app()->assetManager->publish(__DIR__ . '/ei.css');
        $js = Yii::app()->assetManager->publish(__DIR__ . '/ei.js');
        $assetsPath = Yii::app()->assetManager->publish(__DIR__ . '/assets');
        Yii::app()->getClientScript()->registerCssFile($css);
        Yii::app()->getClientScript()->registerScriptFile($js);

        $userLinks = array();
        foreach ($this->users as $userId => $userName) {
            $link = CHtml::link(CHtml::encode($userName), Yii::app()->createUrl($this->userSwitchUrl, array('uid' => $userId)));
            $userLinks[] = "<li>{$link}</li>";
        }
        $settings = array(
            'text' => $this->text,
            'color' => $this->color,
            'position' => $this->position,
            'assetsPath' => $assetsPath,
            'users' => implode($userLinks)
        );
        $settingsJson = CJSON::encode($settings);
        Yii::app()->getClientScript()->registerScript('environmentIndicatorSettings', "window.environmentIndicator = {$settingsJson}", CClientScript::POS_BEGIN);
    }
}
