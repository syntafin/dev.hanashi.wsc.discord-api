<?php
namespace wcf\system\discord\type;
use wcf\data\discord\bot\DiscordBot;
use wcf\data\discord\bot\DiscordBotList;
use wcf\system\discord\DiscordApi;
use wcf\system\exception\UserInputException;
use wcf\system\WCF;

class ChannelMultiSelectDiscordType extends AbstractDiscordType {
    /**
     * Liste von Discord-Bots
     * 
     * @var DiscordBotList
     */
    protected $discordBotList;

    /**
     * Liste von Server-Channeln
     * 
     * @var array
     */
    protected $guildChannels;

    public function getFormElement() {
        $channels = [];
        $guildChannels = $this->getGuildChannels();
        foreach ($this->getDiscordBotList() as $discordBot) {
            $channelsTmp = [];
            if (isset($guildChannels[$discordBot->botID])) {
                $channelsTmp = $guildChannels[$discordBot->botID];
            }
            $channelsTmp = $channelsTmp['body'];
            array_multisort(array_column($channelsTmp, 'position'), SORT_ASC, $channelsTmp);

            $channelsGroupedTmp = [];
            foreach ($channelsTmp as $channel) {
                if (empty($channel['parent_id'])) {
                    $childs = [];
                    if (isset($channelsGroupedTmp[$channel['id']]['childs'])) {
                        $childs = $channelsGroupedTmp[$channel['id']]['childs'];
                    }
                    $channel['childs'] = $childs;
                    $channelsGroupedTmp[$channel['id']] = $channel;
                } else {
                    $channelsGroupedTmp[$channel['parent_id']]['childs'][] = $channel;
                }
            }
            
            $channels[] = [
                'botID' => $discordBot->botID,
                'botName' => $discordBot->botName,
                'channels' => $channelsGroupedTmp
            ];
        }

        WCF::getTPL()->assign([
            'bots' => $channels,
            'optionName' => $this->optionName,
            'value' => $this->value
        ]);

        return [
            'template' => WCF::getTPL()->fetch('discordChannelMultiSelect')
        ];
    }

    public function validate() {
        $guildChannels = $this->getGuildChannels();
        foreach ($this->value as $botID => $channelID) {
            if (empty($channelID)) continue;

            if (!isset($guildChannels[$botID])) {
                throw new UserInputException($this->optionName);
            }
            $channels = $guildChannels[$botID]['body'];
            $channelIDs = array_column($channels, 'id');
            if (!in_array($channelID, $channelIDs)) {
                throw new UserInputException($this->optionName);
            }
        }
    }

    /**
     * gibt Liste von Discord-Bots zurück
     * 
     * @return DiscordBotList
     */
    protected function getDiscordBotList() {
        if ($this->discordBotList === null) {
            $this->discordBotList = new DiscordBotList();
            $this->discordBotList->sqlOrderBy = 'botName ASC';
            $this->discordBotList->readObjects();
        }
        return $this->discordBotList;
    }

    /**
     * Gibt Liste von Discord-Channeln zurück
     * 
     * @return array
     */
    protected function getGuildChannels() {
        if ($this->guildChannels === null) {
            foreach ($this->getDiscordBotList() as $discordBot) {
                $discordApi = $discordBot->getDiscordApi();
                $this->guildChannels[$discordBot->botID] = $discordApi->getGuildChannels();
            }
        }
        return $this->guildChannels;
    }
}