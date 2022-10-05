%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
difficulty=`{cat etc/users/$user/difficulty}
funds=`{cat etc/users/$user/funds}
for(startup in `{ls etc/users/$user/positions}) {
    investment=`{cat $startup/investment}
    funds=`{+ $funds $investment}
    rm -r $startup
}
echo $funds > etc/users/$user/funds

if (~ $REQUEST_METHOD POST && ~ $difficulty ld) {
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
        <button onclick="document.getElementById('click').play()">Play again</button>
    </form><br><br>

    <div class="left">
        <h2>Credits</h2>
        <p>A <a href="https://gelatolabs.xyz" target="_blank" style="color: #0f0">Gelato Labs</a> production for Ludum Dare 51 ("Every 10 seconds")<br><br>
           The Gelato Labs "G-Team" for LD51:<br><br>
           <strong>Programming</strong><br>
           Kyle Farwell (kfarwell)<br><br>
           <strong>Writing</strong><br>
           Ryan Refcio<br>
           Kyle Farwell (kfarwell)<br>
           Jared Kelly (J A R F)<br>
           GPT-3 🤖<br><br>
           <strong>Music and Sound</strong><br>
           Alice Dalton (AliceVibes)<br><br>
           <strong>Art</strong><br>
           DALL·E 🤖<br><br>
           <a href="https://github.com/gelatolabs/vcs2022" target="_blank" style="color: #0f0">Source code</a></p>
    </div>

    <div class="right">
        <h2>Leaderboard</h2>

        <div class="window leaderboard">
            <div class="title-bar">
                <div class="title-bar-text">🧩 Macrosoft Incel - highscores.xls</div>
            </div>
            <div class="window-body">
%               if (~ $REQUEST_METHOD GET) {
                    <form action="" method="POST">
%                       if (~ $difficulty ld) {
                            <div class="field-row">
                                <label for="name">Name</label>
                                <input id="name" name="name" type="text" required />
                                <button onclick="document.getElementById('click').play()">Submit</button>
                            </div>
%                       }
%                       if not {
                            Play on Ludum Dare difficulty to submit your score!
                            <div class="field-row">
                                <label for="name">Name</label>
                                <input id="name" type="text" placeholder="Disabled" required disabled />
                                <button onclick="document.getElementById('click').play()">Submit</button>
                            </div>
%                           }
                    </form><br>
%               }
                <table>
                    <tr class="bold"><td></td><td>Name</td><td>Score</td></tr>
%                   row=1
%                   ifs=$NEW_LINE for(score in `{cat etc/scores | sort -nr | uniq}) {
                        <tr>
                            <td class="bold">%($row%)</td>
                            <td>%(`{echo $score | sed 's/.* //'}%)</td>
                            <td>%(`{echo $score | sed 's/ .*//'}%)</td>
                        </tr>
%                       row=`{+ $row 1}
%                   }
                </table>
            </div>
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
	max-height: 100vh;
	overflow-y: auto;
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
        width: 100%;
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

    div.left {
        float: left;
        width: 50%;
    }
</style>

<audio id="click" src="/snd/click.ogg" />
