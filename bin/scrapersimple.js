// ES5 /TypeScript
var getSubtitles = require('youtube-captions-scraper').getSubtitles;
var args = require('yargs').argv;
getSubtitles({ videoID: args.id, lang: 'en' }).then(function (captions) { console.log(JSON.stringify(captions, null, 4)); });
