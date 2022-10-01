%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
if(~ $#user 0) {
    echo '<button onclick="window.navigation.reload()">Play</a>'
    exit
}

funds=`{cat etc/users/$user/funds}

if({echo $p_investment | grep -q '^[0-9]*$'} &&
   {~ $p_quality good || ~ $p_quality neutral || ~ $p_quality bad}) {
    if(gt $p_investment $funds) {
        echo '<p>You can''t afford that!</p>'
        break
    }
    if not if(lt $p_investment 1000) {
        echo '<p>The minimum investment is $1000!</p>'
        break
    }
    if not {
        funds=`{- $funds $p_investment}

        switch($p_quality) {
        case good
            multiplier=`{x `{shuf -i 110-180 -n 1} 0.01}
        case neutral
            multiplier=`{x `{shuf -i 80-110 -n 1} 0.01}
        case bad
            multiplier=`{x `{shuf -i 1-60 -n 1} 0.01}
        }

        funds=`{int `{+ $funds `{x $p_investment $multiplier}}}

        echo $funds > etc/users/$user/funds
    }
}
%}

<p>Balance: $%($funds%)</p>

<div class="decks">
%   for (quality in `{echo good $NEW_LINE neutral $NEW_LINE bad | shuf}) {
%       name=`{fortune site/data/startup_names}^`{fortune site/data/startup_suffixes}
%       echo -n '<div class="window deck">'
            <div class="title-bar">
                <div class="title-bar-text">🧩 Macrosoft PowerSlides - %($name%).ppt</div>
                <div class="title-bar-controls">
                    <button aria-label="Minimize" onclick="minimizeWin(this)"></button>
                    <button aria-label="Maximize" onclick="maximizeWin(this)"></button>
                    <button aria-label="Close" onclick="closeWin(this)"></button>
                </div>
            </div>
            <div class="window-body">
                <iframe src="slides?name=%($name%)&quality=%($quality%)"></iframe>

                <button class="prev" onclick="prevSlide(this)">◀</button>
                <button class="next" onclick="nextSlide(this)">▶</button>

                <form action="" method="POST">
                    <input type="hidden" name="quality" value="%($quality%)" />
                    <label for="invest%($quality%)">$</label>
                    <input id="invest%($quality%)" name="investment" type="number" min="1000" max="%($funds%)" value="10000" />
                    <button class="invest">Invest</button>
                </form>
            </div>
%       echo -n '</div>'
%   }
</div>

<style>
    html, body {
        margin: 0;
        padding: 0;
    }

    .title-bar {
        background: linear-gradient(90deg, #008000, #10d084)
    }

    .deck {
        display: inline-block;
        width: calc(100vw / 3 - 12px);
        height: calc((100vw / 3 - 28px) * 0.75 + 49px);
        margin: 4px 0 4px 4px;
    }
    .deck:last-child {
        margin-right: 4px;
    }

    .deck .window-body {
        margin: 0;
        text-align: right;
    }

    .deck iframe {
        width: 100%;
        height: calc((100vw / 3 - 28px) * 0.75);
        margin: 0;
        border: none;
    }

    .prev, .next {
        min-width: 0;
        float: left;
    }

    .deck.minimized {
        position: fixed;
        bottom: 0; left: 0;
        height: 24px;
        width: 250px;
    }
    .deck.minimized .window-body {
        display: none;
    }

    .deck.maximized {
        z-index: 100;
        position: fixed;
        top: 0; right: 0; bottom: 0; left: 0;
        width: calc(100% - 6px);
        height: calc(100% - 6px);
        margin: 0;
    }
    .deck.maximized iframe {
        height: calc(100vh - 56px);
    }
</style>

<script>
    function prevSlide(btn) {
        var frame = btn.parentElement.querySelector("iframe").contentWindow;
        frame.scrollTo(0, frame.scrollY - frame.innerHeight - 8);
    }
    function nextSlide(btn) {
        var frame = btn.parentElement.querySelector("iframe").contentWindow;
        frame.scrollTo(0, frame.scrollY + frame.innerHeight + 8);
    }

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
        var win = btn.parentElement.parentElement.parentElement;
        if (win.parentElement.children.length > 1) {
            win.remove();
        }
    }
</script>
