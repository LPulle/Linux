// ES5 /TypeScript
var getSubtitles = require('youtube-captions-scraper').getSubtitles;
const args = require('yargs').argv;
getSubtitles({videoID: args.id, lang: 'en'}).then(captions => {console.log(JSON.stringify(captions, null, 4));});
