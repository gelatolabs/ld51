%{
if(~ $#p_startup 0)
    p_startup=0
if(~ $#p_theme 0)
    p_theme=1
%}

<div class="window form">
    <form action="" method="POST">
        <label for="startup">Startup (0-12)</label>
        <input id="startup" name="startup" type="number" min="0" max="12" value="%($p_startup%)" />
        <label for="theme">Theme (1-5)</label>
        <input id="theme" name="theme" type="number" min="1" max="5" value="%($p_theme%)" />
        <button>Submit</button>
    </form>
</div>

<div class="decks">
%   for (history in `{seq `{wc -l site/data/startups/$p_startup/good/history | sed 's/ .*//'}}) {
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
                <iframe src="testslides?startup=%($p_startup%)&name=%($name%)&quality=good&history=%($history%)&theme=%($p_theme%)"></iframe>

                <button class="prev" onclick="prevSlide(this)">◀</button>
                <button class="next" onclick="nextSlide(this)">▶</button>

                <form action="/sell" method="POST">
                    <input type="hidden" name="startup" value="%($p_startup%)" />
                    <input type="hidden" name="name" value="%($name%)" />
                    <input type="hidden" name="quality" value="%($quality%)" />
                    <label for="invest%($quality%)">$</label>
                    <input id="invest%($quality%)" name="investment" type="number" min="1" max="%($funds%)" value="%(`{min 10 $funds}%)" />
                    <button class="invest">Invest</button>
                </form>
            </div>
%       echo -n '</div>'
%   }

%   for (history in `{seq `{wc -l site/data/startups/$p_startup/bad/history | sed 's/ .*//'}}) {
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
                <iframe src="testslides?startup=%($p_startup%)&name=%($name%)&quality=bad&history=%($history%)&theme=%($p_theme%)"></iframe>

                <button class="prev" onclick="prevSlide(this)">◀</button>
                <button class="next" onclick="nextSlide(this)">▶</button>

                <form action="/sell" method="POST">
                    <input type="hidden" name="startup" value="%($p_startup%)" />
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

<style>
    html, body {
        margin: 0;
        padding: 0;
        background: linear-gradient(180deg, #00f, #000);
    }

    .form {
        z-index: 1;
        position: fixed;
        top: 0; left: 0;
    }

    .decks {
        margin-top: 21em;
    }

    .title-bar {
        background: linear-gradient(90deg, #fa2301, #f37836)
    }

    .deck {
        display: inline-block;
        width: calc(100vw / 3 - 16px);
        height: calc((100vw / 3 - 28px) * 0.75 + 49px);
        margin: 0 0 4px 4px;
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
</script>
