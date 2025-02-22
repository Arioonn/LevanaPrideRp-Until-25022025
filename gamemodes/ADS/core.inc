
#define MAX_ADVERTISEMENTS							(500)
enum adsQueue {
    adsExists,
    adsContact,
    adsType,
    adsContent[128],
    adsContactName[52],
    adsMinutes,
    adsUsed,
    adsAntri
};

new AdsQueue[MAX_ADVERTISEMENTS][adsQueue];
new ListedAds[MAX_PLAYERS][10];
