-- [Q] [A] The Missing Diplomat
-- Dashel Stonefist SAI
SET @ENTRY := 4961;
SET @QUEST := 1447;
SET @SPELL_PUMMEL := 12555;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
UPDATE `quest_template` SET `StartScript`=0,`CompleteScript`=0,`EmoteOnComplete`=11 WHERE `id`=@QUEST; -- ONESHOT_LAUGH
UPDATE `quest_template` SET `EmoteOnComplete`=14 WHERE `id`=1246; -- Previous version should make him rude against player
DELETE FROM `quest_start_scripts` WHERE `id`=@QUEST;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY*100,@ENTRY*100+1) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,13,0,100,0,6000,21000,0,0,11,@SPELL_PUMMEL,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - Player Casting - Cast Pummel"),
(@ENTRY,0,1,0,19,0,100,0,@QUEST,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Quest Accept - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Say Line 0"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,2,168,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Set Faction Hostile"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Attack Player"),
(@ENTRY*100,9,3,0,0,0,100,0,2000,2000,0,0,12,4969,1,300000,0,0,0,8,0,0,0,-8678.246094,440.952606,99.620926,4.364815,"Dashel Stonefist - On Script - Summon Old Town Thug"),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,12,4969,1,300000,0,0,0,8,0,0,0,-8682.465820,441.471161,99.531319,4.871392,"Dashel Stonefist - On Script - Summon Old Town Thug"),
(@ENTRY,0,2,0,2,0,100,0,0,15,0,0,80,@ENTRY*100+1,0,2,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On 15% HP - Run Script"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,15,@QUEST,0,0,0,0,0,7,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Quest Credit"), -- We are putting this before evade else we lose our target
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,20,9,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Stop Attacking"),
(@ENTRY*100+1,9,2,0,0,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Evade"),
(@ENTRY*100+1,9,3,0,0,0,100,0,0,0,0,0,2,84,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Set Faction Back"),
(@ENTRY*100+1,9,4,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Say Line 1"),
(@ENTRY*100+1,9,5,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dashel Stonefist - On Script - Say Line 2");
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Now you're going to get it good!",12,0,100,0,0,0,"Dashel Stonefist"),
(@ENTRY,1,0,"Okay, okay! Enough fighting. No one else needs to get hurt.",12,0,100,0,0,0,"Dashel Stonefist"),
(@ENTRY,2,0,"It's okay, boys. Back off. You've done enough. I'll meet up with you later.",12,0,100,0,0,0,"Dashel Stonefist");
