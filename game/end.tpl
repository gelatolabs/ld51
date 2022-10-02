%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
funds=`{cat etc/users/$user/funds}
for(startup in `{ls etc/users/$user/positions}) {
    investment=`{cat $startup/investment}
    funds=`{+ $funds $investment}
    rm -r $startup
}

if (~ $REQUEST_METHOD POST) {
    p_name=`{echo $p_name | tr -cd '[a-zA-Z0-9]'}
    echo $funds $p_name >> etc/scores
}
%}

<main>
    <h1>The end</h1>
    <p>Congratulations to you,  cold and heartless investor!  You achieved a sum of $%($funds%) as a result of your
       strategic allocation of funds.  Although we're sure you can do better next time - give it another
       shot to see if you can retire with a phatter wallet!</p>
    <form action="menu" method="POST">
        <button>Play again</button>
    </form><br><br>

    <div class="window leaderboard">
        <div class="title-bar">
            <div class="title-bar-text">🧩 Macrosoft Incel - highscores.xls</div>
        </div>
        <div class="window-body">
%           if (~ $REQUEST_METHOD GET) {
                <form action="" method="POST">
                    <div class="field-row">
                        <label for="name">Name</label>
                        <input id="name" name="name" type="text" required />
                        <button>Submit</button>
                    </div>
                </form><br>
%           }
            <table>
                <tr class="bold"><td></td><td>Name</td><td>Score</td></tr>
%               row=1
%               ifs=$NEW_LINE for(score in `{cat etc/scores | sort -n | uniq}) {
                    <tr>
                        <td class="bold">%($row%)</td>
                        <td>%(`{echo $score | sed 's/.* //'}%)</td>
                        <td>%(`{echo $score | sed 's/ .*//'}%)</td>
                    </tr>
%                   row=`{+ $row 1}
%               }
            </table>
        </div>
    </div>
</main>

<style>
    html, body {
        height: 100%;
        background: linear-gradient(180deg, #00f, #000);
        overflow-y: hidden;
    }

    main {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: #ff0;
    }

    p {
        font-size: 150%;
    }

    .title-bar {
        background: linear-gradient(90deg, #68cc2c, #6bc065)
    }

    .leaderboard {
        display: inline-block;
    }

    .leaderboard .window-body {
        margin: 0;
        padding: 8px;
        text-align: center;
        color: #000;
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

    .bold {
        font-weight: bold;
    }
</style>
