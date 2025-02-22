#include <a_samp>

#define MAX_CARDS 10     // Define the maximum cards in a hand
#define MAX_PLAYERS 100  // Define the maximum number of players

// Constants and variables
new const CARDS[] = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 
    11, 12, 13, 14, 15, 16, 17, 18, 
    19, 20, 21, 22, 23, 24, 25, 26, 
    27, 28, 29, 30, 31, 32, 33, 34, 
    35, 36, 37, 38, 39, 40, 41, 42, 
    43, 44, 45, 46, 47, 48, 49, 50, 
    51, 52 // replace with actual card mappings
};

#define CARDS_SIZE (sizeof(CARDS)/sizeof(CARDS[0]))

new playerHand[MAX_PLAYERS][MAX_CARDS]; // Player hands (MAX_CARDS determine the max number of cards per hand)
new dealerHand[MAX_CARDS];              // Dealer hand
new playerScore[MAX_PLAYERS];
new dealerScore;
new cardCount[MAX_PLAYERS];             // Track number of cards dealt to player
new betAmount[MAX_PLAYERS];             // Bet amount for each player
new winStreak[MAX_PLAYERS];             // Track the player's win streak
//new streakReward = 1000;                // Reward amount for winning streak

CMD:blackjack(playerid, params[])
{
    if (sscanf(params, "d", betAmount[playerid]) == 1)
    {
        StartBlackjack(playerid);
    }
    else
    {
        SendClientMessage(playerid, -1, "Usage: /blackjack [bet amount]");
    }
    return 1;
}

CMD:hit(playerid)
{
    Hit(playerid);
    return 1;
}

CMD:stand(playerid)
{
    Stand(playerid);
    return 1;
}

StartBlackjack(playerid)
{
    new money = pData[playerid][pMoney];
    if (betAmount[playerid] <= 0 || betAmount[playerid] > money)
    {
        SendClientMessage(playerid, -1, "Invalid bet amount. Make sure you have enough money.");
        return;
    }

    // Deduct bet amount from player money
    pData[playerid][pMoney] -= betAmount[playerid];

    // Initialize the player's game state
    cardCount[playerid] = 0;
    winStreak[playerid] = 0; // Reset win streak
// Deal two cards to player and dealer
    playerHand[playerid][cardCount[playerid]++] = DealCard();
    playerHand[playerid][cardCount[playerid]++] = DealCard();
    dealerHand[0] = DealCard();
    dealerHand[1] = DealCard();

    // Calculate initial scores
    playerScore[playerid] = CalculateScore(playerHand[playerid], cardCount[playerid]);
    dealerScore = CalculateScore(dealerHand, 2);

    // Display cards to player
    DisplayCards(playerid);

    // Check for natural Blackjack
    if (playerScore[playerid] == 21)
    {
        if (dealerScore == 21)
        {
            DisplayDealerCards(playerid);
            SendClientMessage(playerid, -1, "Both you and the dealer have Blackjack. It's a tie.");
            pData[playerid][pMoney] += betAmount[playerid];
        }
        else
        {
            SendClientMessage(playerid, -1, "You have Blackjack! You win!");
            pData[playerid][pMoney] += betAmount[playerid] * 2.5;
            winStreak[playerid]++;
            SendReward(playerid);
        }
        EndGame(playerid);
    }
    else
    {
        SendClientMessage(playerid, -1, "Game started! Use /hit to draw another card or /stand to hold.");
    }
}

DealCard()
{
    return CARDS[random(sizeof(CARDS))]; // Menggunakan ukuran array untuk memilih kartu secara acak
}

CalculateScore(hand[], card_num)
{
    new score = 0;
    new ace_count = 0;
    for (new i = 0; i < card_num; i++)
    {
        if (IsAce(hand[i]))
            ace_count++;
        score += CardValue(hand[i]);
    }
    while (score > 21 && ace_count > 0)
    {
        score -= 10;
        ace_count--;
    }
    return score;
}

CardValue(card)
{
    // Add logic to determine card value
    if (IsFaceCard(card)) // Assuming IsFaceCard is a separate check for Jack, Queen, King
        return 10;

    // For Ace
    if (IsAce(card))
        return 11; // Initially count Ace as 11

    // For numbered cards
    return GetCardNumber(card); // Assuming GetCardNumber returns value of card 2-10
}

IsAce(card)
{
    // Logic to determine if the card is an Ace (e.g., if card value is 1)
    return card % 13 == 1;
}

IsFaceCard(card)
{
    // Logic to determine if the card is a face card (Jack, Queen, King) (e.g., if card value is 11, 12, 13)
    return card % 13 >= 11 && card % 13 <= 13;
}

GetCardNumber(card)
{
    // Logic to extract the card number from the card object
    // Assuming card values range from 1 (Ace) to 13 (King)
    return card % 13 + 1;
}

DisplayCards(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    // Clear previous card objects if needed

    // Display player's cards
    for (new i = 0; i < cardCount[playerid]; i++)
    {
        CreateObject(CARDS[playerHand[playerid][i]], x + (i * 1.5), y, z + 1.0, 0.0, 0.0, 0.0);
    }

    // Display dealer's initial cards (only show one card initially)
    CreateObject(CARDS[dealerHand[0]], x + 3.0, y + 2.0, z + 1.0, 0.0, 0.0, 0.0);
}

Hit(playerid)
{
    if (cardCount[playerid] >= MAX_CARDS)
    {
        SendClientMessage(playerid, -1, "You cannot draw more cards.");
        return;
    }

    // Deal a new card to player
    playerHand[playerid][cardCount[playerid]++] = DealCard();
    playerScore[playerid] = CalculateScore(playerHand[playerid], cardCount[playerid]);

    // Display updated cards
    DisplayCards(playerid);

    // Check if player busts
    if (playerScore[playerid] > 21)
    {
        SendClientMessage(playerid, -1, "You busted! Dealer wins.");
        winStreak[playerid] = 0; // Reset win streak
        EndGame(playerid);
    }
    else if (playerScore[playerid] == 21)
    {
        Stand(playerid);
    }
}

Stand(playerid)
{
    // Dealer's turn
    new dealerCardCount = 2;
    while (dealerScore < 17 && dealerCardCount < MAX_CARDS)
    {
        dealerHand[dealerCardCount++] = DealCard();
        dealerScore = CalculateScore(dealerHand, dealerCardCount);
    }

    // Display dealer's final hand
    DisplayDealerCards(playerid);

    // Determine winner
    if (dealerScore > 21 || playerScore[playerid] > dealerScore)
    {
        pData[playerid][pMoney] += betAmount[playerid] * 2; // Player wins, double the bet amount
        SendClientMessage(playerid, -1, "You win!");
        winStreak[playerid]++;
        SendReward(playerid);
    }
    else if (playerScore[playerid] < dealerScore)
    {
        SendClientMessage(playerid, -1, "Dealer wins.");
        winStreak[playerid] = 0; // Reset win streak
    }
    else
    {
        pData[playerid][pMoney] += betAmount[playerid]; // Push, return the bet amount
        SendClientMessage(playerid, -1, "It's a tie.");
    }

    EndGame(playerid);
}

DisplayDealerCards(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    // Display all dealer's cards
    for (new i = 0; i < MAX_CARDS; i++)
    {
        CreateObject(CARDS[dealerHand[i]], x + (i * 1.5), y + 2.0, z + 1.0, 0.0, 0.0, 0.0);
    }
}

EndGame(playerid)
{
    // Reset all game variables for the player
    for (new i = 0; i < MAX_CARDS; i++)
    {
        playerHand[playerid][i] = 0;
    }
    playerScore[playerid] = 0;
    cardCount[playerid] = 0;
    betAmount[playerid] = 0;
    // Any additional cleanup if required
}

SendReward(playerid)
{
    if (winStreak[playerid] >= 3)
    {
        new reward = 1000; // Example reward amount
        pData[playerid][pMoney] += reward;
        SendClientMessage(playerid, -1, "You have won 3 times in a row! You receive a bonus reward of $1000.");
        winStreak[playerid] = 0; // Reset win streak after giving bonus
    }
}
