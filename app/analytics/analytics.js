function topWords(callback) {
    callback(null, {'topWords': 'topWords'});
}

function messageCount(callback) {
    callback(null, {'messageCount': 'messageCount'});
}


module.exports = {
    topWords: topWords,
    messageCount: messageCount
};