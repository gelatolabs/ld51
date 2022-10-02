%{
user=`{get_cookie id | sed 's/[^a-z0-9]//g'}
if(~ $#user 0) {
    echo '<a href="/">Play</a>'
    exit
}

funds=`{cat etc/users/$user/funds}

if(! ~ $#post_args 0) {
    for(startup in $post_args) {
        startup=`{echo $startup | sed 's/^p_//'}
        value=`{cat etc/users/$user/positions/$startup/investment}
        funds=`{+ $funds $value}
        rm -r etc/users/$user/positions/$startup
    }
    echo $funds > etc/users/$user/funds
}
%}

<h1 id="funds">💰 $%($funds%)</h1>
<h1 id="timer">10 ⏱</h1>

<div class="decks">
%   for (quality in `{echo good $NEW_LINE bad $NEW_LINE bad | shuf}) {
%       startup=`{basename `{ls site/data/startups | shuf -n 1}}
%       name=`{fortune site/data/names/prefixes}^`{fortune site/data/names/suffixes}
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
                <iframe src="slides?startup=%($startup%)&name=%($name%)&quality=%($quality%)"></iframe>

                <button class="prev" onclick="prevSlide(this)">◀</button>
                <button class="next" onclick="nextSlide(this)">▶</button>

                <form action="/sell" method="POST">
                    <input type="hidden" name="startup" value="%($startup%)" />
                    <input type="hidden" name="name" value="%($name%)" />
                    <input type="hidden" name="quality" value="%($quality%)" />
                    <label for="invest%($quality%)">$</label>
                    <input id="invest%($quality%)" name="investment" type="number" min="1" max="%($funds%)" value="%(`{min 10 $funds}%)" />
                    <button class="invest">Invest</button>
                </form>
            </div>
%       echo -n '</div>'
%   }
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

    .decks {
        position: absolute;
        top: 0;
        height: 100%;
    }

    .title-bar {
        background: linear-gradient(90deg, #fa2301, #f37836)
    }

    .deck {
        display: inline-block;
        width: calc(100vw / 3 - 12px);
        height: calc((100vw / 3 - 28px) * 0.75 + 49px);
        margin: 50vh 0 4px 4px;
        transform: translateY(-50%);
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
        width: auto;
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
        transform: none;
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

    var timer = 10;
    setInterval(function() {
        if (timer <= 0) {
            window.location.href = "timeup";
        } else {
            document.getElementById("timer").innerHTML = timer + " ⏱";
        }
        //timer -= 1;
    }, 1000);
</script>
