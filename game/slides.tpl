<main class="theme%(`{shuf -i 1-5 -n 1}%)">
    <div class="slide logo">
        <h1>%($q_name%)</h1>
        <p>%($q_quality%)</p>
    </div>
    <div class="slide vision">
        <h5>%(`{/usr/games/fortune -s wisdom}%)</h5>
    </div>
    <div class="slide">
        <p>thank u for coming to our ted talk</p>
    </div>
</main>

<style>
    body {
        overflow-x: hidden;
    }

    main {
        position: absolute;
        top: 0;
        left: 0;
        background-color: #fff;
    }

    .slide {
        width: calc(100vw - 16px);
        height: calc((100vw - 16px) * 0.75);
        margin: 0 0 8px 0;
    }
    .slide:last-child {
        margin-bottom: 0;
    }

    h1, h2, h3, h4, h5, h6, p {
        margin: 0 2vw;
    }

    h1 { font-size: 10vw; }
    h2 { font-size: 9vw; }
    h3 { font-size: 8vw; }
    h4 { font-size: 7vw; }
    h5 { font-size: 6vw; }
    h6 { font-size: 5vw; }
    p, li { font-size: 4vw; }

    .theme1 .slide {
        background: #000;
        color: #fff;
        font-family: sans-serif;
    }
    .theme2 .slide {
        background: #f00;
        color: #0ff;
        font-family: "Comic Sans MS", "Chalkboard SE", "Comic Neue", cursive, sans-serif;
    }
    .theme3 .slide {
        background: #0f0;
        color: #f0f;
        font-family: "Comic Sans MS", "Chalkboard SE", "Comic Neue", cursive, sans-serif;
    }
    .theme4 .slide {
        background: #00f;
        color: #ff0;
        font-family: "Comic Sans MS", "Chalkboard SE", "Comic Neue", cursive, sans-serif;
    }
    .theme5 .slide {
        background: #fff;
        color: #000;
        font-family: serif;
    }

    .slide.logo {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }

    .slide.vision {
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        background: url("https://picsum.photos/800/600?random=%($q_quality%)");
    }
    .slide.vision h5 {
        color: #fff;
        text-shadow: 0 0 1vw #000;
    }
</style>
