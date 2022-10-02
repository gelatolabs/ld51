%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
if(~ $#user 0) {
    echo '<a href="/">Play</a>'
    exit
}

funds=`{cat etc/users/$user/funds}

if({! ~ $#p_startup 0} &&
   {! ~ $#p_name 0} &&
   {echo $p_investment | grep -q '^[0-9]*$'} &&
   {~ $p_quality good || ~ $p_quality bad}) {
    if(gt $p_investment $funds) {
        echo '<p>You can''t afford that! <a href="/invest">Back</a></p>'
        exit
    }
    if not {
        funds=`{- $funds $p_investment}
        echo $funds > etc/users/$user/funds

        id=`{uuidgen | sed 's/-//g'}
        mkdir -p etc/users/$user/positions/$id
        echo $p_startup > etc/users/$user/positions/$id/startup
        echo $p_name > etc/users/$user/positions/$id/name
        echo $p_quality > etc/users/$user/positions/$id/quality
        echo $p_investment > etc/users/$user/positions/$id/investment
    }
}
%}

<h1 id="funds">💰 $%($funds%)</h1>
<h1 id="timer">10 ⏱</h1>

<div class="window stonks">
    <div class="title-bar">
        <div class="title-bar-text">🧩 Macrosoft Incel - stonks.xls</div>
        <div class="title-bar-controls">
            <button aria-label="Minimize" onclick="minimizeWin(this)"></button>
            <button aria-label="Maximize" onclick="maximizeWin(this)"></button>
            <button aria-label="Close" onclick="closeWin(this)"></button>
        </div>
    </div>
    <div class="window-body">
        <form id="form" action="/invest" method="POST">
            <table>
                <tr class="bold"><td></td><td>Company</td><td>Position</td><td>Change</td><td>News</td></tr>
%               row=1
%               for(startup in `{ls -tr etc/users/$user/positions}) {
%{
                    id=`{cat $startup/startup}
                    name=`{cat $startup/name}
                    quality=`{cat $startup/quality}
                    investment=`{cat $startup/investment}

                    switch($quality) {
                    case good
                        if(gt `{shuf -i 1-10 -n 1} 3) {
                            if(~ `{shuf -i 1-2 -n 1} 1)
                                news=`{fortune site/data/startups/$id/news/good}
                            if not
                                news=`{fortune site/data/news/good}
                            change=`{int `{x `{x `{shuf -i 10-80 -n 1} 0.01} $investment}}
                        }
                        if not {
                            if(~ `{shuf -i 1-2 -n 1} 1)
                                news=`{fortune site/data/startups/$id/news/bad}
                            if not
                                news=`{fortune site/data/news/bad}
                            change=-`{int `{x `{x `{shuf -i 10-40 -n 1} 0.01} $investment}}
                        }
                    case bad
                        if(gt `{shuf -i 1-10 -n 1} 7) {
                            if(~ `{shuf -i 1-2 -n 1} 1)
                                news=`{fortune site/data/startups/$id/news/good}
                            if not
                                news=`{fortune site/data/news/good}
                            change=`{int `{x `{x `{shuf -i 10-40 -n 1} 0.01} $investment}}
                        }
                        if not {
                            if(~ `{shuf -i 1-2 -n 1} 1)
                                news=`{fortune site/data/startups/$id/news/bad}
                            if not
                                news=`{fortune site/data/news/bad}
                            change=-`{int `{x `{x `{shuf -i 10-80 -n 1} 0.01} $investment}}
                        }
                    }
                    investment=`{+ $investment $change}
                    echo $investment > $startup/investment
%}
                    <tr>
                        <td class="bold">%($row%)</td>
                        <td>%($name%)</td>
                        <td>$%($investment%)</td>
%                       if(gt $change 0) {
                            <td class="increase">+%($change%)</td>
%                       }
%                       if not {
                            <td class="decrease">%($change%)</td>
%                       }
                        <td>%($news%)</td>
                        <td class="checkbox">
                            <input type="checkbox" id="%(`{basename $startup}%)" name="%(`{basename $startup}%)" value="sell">
                            <label for="%(`{basename $startup}%)">Sell</label>
                        </td>
                    </tr>

%                   row=`{+ $row 1}
%               }
            </table>
            <br><button>Continue</button>
        </form>
    </div>
</div>

<button class="menu" onclick="window.location.href = 'menu'">Menu</button>

<style>
    html, body {
        margin: 0;
        padding: 0;
        height: 100%;
        background: linear-gradient(180deg, #00f, #000);
        overflow-y: hidden;
    }

    body > h1 {
        margin: 0.2em;
        color: #ff0;
    }
    #funds {
        float: left;
    }
    #timer {
        float: right;
    }

    .menu {
        position: absolute;
        bottom: 4px; left: 50%;
        transform: translateX(-50%);
    }

    .title-bar {
        background: linear-gradient(90deg, #68cc2c, #6bc065)
    }

    .stonks {
        position: absolute;
        top: 50%; left: 50%;
        transform: translate(-50%, -50%);
        max-height: calc(100vh - 270px);
    }

    .stonks .window-body {
        max-height: calc(100vh - 310px);
        overflow-y: auto;
        margin: 0;
        padding: 8px;
        text-align: center;
    }

    table {
        border-collapse: collapse;
        text-align: left;
    }

    td {
        padding: 3px 3px 2px 3px;
        border: 1px solid silver;
    }

    td:not(.bold) {
        background-color: #fff;
    }
    .bold td {
        background-color: silver;
    }

    .increase {
        color: #0f0;
    }
    .decrease {
        color: #f00;
    }

    .bold {
        font-weight: bold;
    }

    .stonks.minimized {
        position: fixed;
        top: unset; bottom: 0; left: 0;
        transform: none;
        height: 24px;
        width: auto;
    }
    .stonks.minimized .window-body {
        display: none;
    }

    .stonks.maximized {
        z-index: 100;
        position: fixed;
        top: 0; right: 0; bottom: 0; left: 0;
        transform: none;
        width: calc(100% - 6px);
        height: calc(100% - 6px);
        margin: 0;
        max-height: none;
    }
    .stonks.maximized .window-body {
        max-height: calc(100vh - 46px);
    }
</style>

<script>
    function minimizeWin(btn) {
        var win = btn.parentElement.parentElement.parentElement;
        win.classList.toggle("minimized");
        win.classList.remove("maximized");
        win.querySelectorAll("[aria-label='Restore']")[0].ariaLabel = "Maximize";
    }

    function maximizeWin(btn) {
        var win = btn.parentElement.parentElement.parentElement;
        win.classList.toggle("maximized");
        win.classList.remove("minimized");

        if (btn.ariaLabel == "Maximize") {
            btn.ariaLabel = "Restore";
        } else {
            btn.ariaLabel = "Maximize";
        }
    }

    function closeWin(btn) {
        window.location.href = "invest";
    }

    var timer = 10;
    setInterval(function() {
        if (timer <= 0) {
            document.getElementById("form").submit();
        } else {
            document.getElementById("timer").innerHTML = timer + " ⏱";
        }
        timer -= 1;
    }, 1000);
</script>
