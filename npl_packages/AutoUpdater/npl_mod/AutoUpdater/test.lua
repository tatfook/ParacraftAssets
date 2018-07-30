--[[
Title: 
Author(s): leio
Date: 2017/10/13
Desc: 
use the lib:
------------------------------------------------------------
NPL.load("npl_mod/AutoUpdater/test.lua");
local test = commonlib.gettable("Mod.AutoUpdater.test");
test.testAssetsManager();

------------------------------------------------------------
]]
NPL.load("npl_mod/AutoUpdater/AssetsManager.lua");
local AssetsManager = commonlib.gettable("Mod.AutoUpdater.AssetsManager");
local test = commonlib.gettable("Mod.AutoUpdater.test");
function test.testAssetsManager()
    NPL.load("(gl)script/ide/timer.lua");
    local redist_root = "test/";
	ParaIO.CreateDirectory(redist_root);

    NPL.load("npl_mod/AutoUpdater/AssetsManager.lua");
    local AssetsManager = commonlib.gettable("Mod.AutoUpdater.AssetsManager");
    local a = AssetsManager:new();
    local timer;
    a:onInit(redist_root,"npl_mod/AutoUpdater/configs/paracraft.xml",function(state)
        if(state)then
            if(state == AssetsManager.State.PREDOWNLOAD_VERSION)then
                echo("=========PREDOWNLOAD_VERSION");
            elseif(state == AssetsManager.State.DOWNLOADING_VERSION)then
                echo("=========DOWNLOADING_VERSION");
            elseif(state == AssetsManager.State.VERSION_CHECKED)then
                echo("=========VERSION_CHECKED");
            elseif(state == AssetsManager.State.VERSION_ERROR)then
                echo("=========VERSION_ERROR");
            elseif(state == AssetsManager.State.PREDOWNLOAD_MANIFEST)then
                echo("=========PREDOWNLOAD_MANIFEST");
            elseif(state == AssetsManager.State.DOWNLOADING_MANIFEST)then
                echo("=========DOWNLOADING_MANIFEST");
            elseif(state == AssetsManager.State.MANIFEST_DOWNLOADED)then
                echo("=========MANIFEST_DOWNLOADED");
            elseif(state == AssetsManager.State.MANIFEST_ERROR)then
                echo("=========MANIFEST_ERROR");
            elseif(state == AssetsManager.State.PREDOWNLOAD_ASSETS)then
                echo("=========PREDOWNLOAD_ASSETS");
                timer = commonlib.Timer:new({callbackFunc = function(timer)
                    echo(a:getPercent());
                end})
                timer:Change(0, 100)
            elseif(state == AssetsManager.State.DOWNLOADING_ASSETS)then
                echo("=========DOWNLOADING_ASSETS");
            elseif(state == AssetsManager.State.ASSETS_DOWNLOADED)then
                echo("=========ASSETS_DOWNLOADED");
                echo(a:getPercent());
                if(timer)then
                    timer:Change();
                end
                a:apply();
            elseif(state == AssetsManager.State.ASSETS_ERROR)then
                echo("=========ASSETS_ERROR");
            elseif(state == AssetsManager.State.PREUPDATE)then
                echo("=========PREUPDATE");
            elseif(state == AssetsManager.State.UPDATING)then
                echo("=========UPDATING");
            elseif(state == AssetsManager.State.UPDATED)then
                echo("=========UPDATED");
            elseif(state == AssetsManager.State.FAIL_TO_UPDATED)then
                echo("=========FAIL_TO_UPDATED");
            end    
        end
    end);
    a:check(nil,function()
        local cur_version = a:getCurVersion();
        local latest_version = a:getLatestVersion();
        echo("=========version");
        echo({cur_version = cur_version, latest_version = latest_version});
        if(a:isNeedUpdate())then
            a:download();
        else
            echo("=========is latest version");
        end
    end);
end
