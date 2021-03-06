-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:16 PM

local QuestID = 251;
local ReqClv = 20;
local ReqJlv = 0;
local NextQuest = 252;
local RewZeny = 404;
local RewCxp = 1950;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 0;
local RewItem2 = 0;
local RewItemCount1 = 0;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	-- Initialize all quest steps
	Saga.AddStep(cid, QuestID, 25101);
	Saga.AddStep(cid, QuestID, 25102);

	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.InsertQuest(cid, NextQuest, 1);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end


function QUEST_STEP_1(cid, StepID)
	--Talk with Monika Reynolds
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1012);

	--Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1012 then
		Saga.GeneralDialog(cid, 3219);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end

	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end

	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	--Report Submission Lutz Tristan
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1150);

	--Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1150 then
		Saga.GeneralDialog(cid, 3222);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end

	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end

	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local StepID = CurStepID;
	local ret = -1;

	if CurStepID == 25101 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 25102 then
		ret = QUEST_STEP_2(cid, StepID);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end
