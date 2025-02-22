#include <a_samp> //Masih belu jadi jadi biarin dah dulu wkwkwk
#include <a_http>

#define GPT_API_KEY "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"
#define GPT_API_URL "https://api.openai.com/v1/completions"

forward HTTPResponseCallback(http_id, response_code, data[], data_size);
public HTTPResponseCallback(http_id, response_code, data[], data_size)
{
    if (response_code == 200)
    {
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i))
            {
                SendClientMessage(i, 0xFFFFFFAA, data);
            }
        }
    }
    else
    {
        print("Failed to get response from API.");
    }
    return 1;
}

CMD:translate(playerid, params[])
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xFFE4C4FF, "USAGE: {FFFFFF}/translate [text]");
        return 1;
    }

    new requestData[1024];
    format(requestData, sizeof(requestData), "{\"model\": \"text-davinci-002\", \"prompt\": \"Translate the following text to French: %s\", \"max_tokens\": 100}", params);

    new headerData[256];
    format(headerData, sizeof(headerData), "Content-Type: application/json Authorization: Bearer %s", GPT_API_KEY);
    return 1;
}