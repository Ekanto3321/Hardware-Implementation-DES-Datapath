#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

/* Table positions are numbered from 1, starting at the MSB. */
static const uint8_t E[48] = {
    32, 1, 2, 3, 4, 5,
    4, 5, 6, 7, 8, 9,
    8, 9, 10, 11, 12, 13,
    12, 13, 14, 15, 16, 17,
    16, 17, 18, 19, 20, 21,
    20, 21, 22, 23, 24, 25,
    24, 25, 26, 27, 28, 29,
    28, 29, 30, 31, 32, 1};

static const uint8_t P[32] = {
    16, 7, 20, 21,
    29, 12, 28, 17,
    1, 15, 23, 26,
    5, 18, 31, 10,
    2, 8, 24, 14,
    32, 27, 3, 9,
    19, 13, 30, 6,
    22, 11, 4, 25};

static const uint8_t S[8][4][16] = {
    /* S1 */
    {
        {14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7},
        {0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8},
        {4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0},
        {15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13}},
    /* S2 */
    {
        {15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10},
        {3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5},
        {0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15},
        {13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9}},
    /* S3 */
    {
        {10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8},
        {13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1},
        {13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7},
        {1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12}},
    /* S4 */
    {
        {7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15},
        {13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9},
        {10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4},
        {3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14}},
    /* S5 */
    {
        {2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9},
        {14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6},
        {4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14},
        {11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3}},
    /* S6 */
    {
        {12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11},
        {10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8},
        {9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6},
        {4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13}},
    /* S7 */
    {
        {4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1},
        {13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6},
        {1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2},
        {6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12}},
    /* S8 */
    {
        {13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7},
        {1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2},
        {7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8},
        {2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11}}};

/* Read selected input bits and append them in table order. */
static uint64_t permute(
    uint64_t input,
    const uint8_t *table,
    unsigned output_bits,
    unsigned input_bits)
{
    uint64_t output = 0;

    for (unsigned i = 0; i < output_bits; ++i)
    {
        unsigned shift = input_bits - table[i];
        uint64_t bit = (input >> shift) & UINT64_C(1);

        output = (output << 1) | bit;
    }

    return output;
}

/* Complete DES round function: E -> XOR -> S-boxes -> P. */
static uint32_t des_f(uint32_t right, uint64_t round_key)
{
    uint64_t expanded = permute(right, E, 48, 32);

    uint64_t mixed =
        expanded ^ (round_key & UINT64_C(0xFFFFFFFFFFFF));

    uint32_t substituted = 0;

    printf("E(R0)       = %012" PRIX64 "\n", expanded);
    printf("E(R0) XOR K = %012" PRIX64 "\n", mixed);

    for (unsigned i = 0; i < 8; ++i)
    {
        /* Process the leftmost 6-bit group first. */
        unsigned shift = 42 - 6 * i;
        uint8_t six = (uint8_t)((mixed >> shift) & 0x3F);

        /* Outer bits select the row; middle four select the column. */
        unsigned row = ((six & 0x20) >> 4) | (six & 0x01);
        unsigned col = (six >> 1) & 0x0F;

        uint8_t four = S[i][row][col];

        substituted = (substituted << 4) | four;

        printf(
            "S%u: input=%02X row=%u col=%2u output=%X\n",
            i + 1, (unsigned)six, row, col, (unsigned)four);
    }

    uint32_t result = (uint32_t)permute(substituted, P, 32, 32);

    printf("S-box output= %08" PRIX32 "\n", substituted);
    printf("F(R0, K)    = %08" PRIX32 "\n", result);

    return result;
}

/* Input and output are packed as L || R. */
static uint64_t des_round(uint64_t input, uint64_t round_key)
{
    uint32_t left = (uint32_t)(input >> 32);
    uint32_t right = (uint32_t)input;

    uint32_t next_left = right;
    uint32_t next_right = left ^ des_f(right, round_key);

    printf("L1          = %08" PRIX32 "\n", next_left);
    printf("R1          = %08" PRIX32 "\n", next_right);

    return ((uint64_t)next_left << 32) | next_right;
}

int main(void)
{
    const struct {
        uint64_t input;
        uint64_t round_key;
        uint64_t expected;
    } tests[] = {
        /* Original test */
        {
            UINT64_C(0xCC00CCFFF0AAF0AA),
            UINT64_C(0x1B02EFFC7072),
            UINT64_C(0xF0AAF0AAEF4A6544)
        },

        /* All-zero input and key */
        {
            UINT64_C(0x0000000000000000),
            UINT64_C(0x000000000000),
            UINT64_C(0x00000000D8D8DBBC)
        },

        /* All-one input and key */
        {
            UINT64_C(0xFFFFFFFFFFFFFFFF),
            UINT64_C(0xFFFFFFFFFFFF),
            UINT64_C(0xFFFFFFFF27272443)
        },

        /* Mixed input and key */
        {
            UINT64_C(0x0123456789ABCDEF),
            UINT64_C(0x123456789ABC),
            UINT64_C(0x89ABCDEFB1363FBC)
        },

        /* Nonzero left half, zero right half and key */
        {
            UINT64_C(0x1234567800000000),
            UINT64_C(0x000000000000),
            UINT64_C(0x00000000CAEC8DC4)
        },

        /* Zero left half, all-one right half, zero key */
        {
            UINT64_C(0x00000000FFFFFFFF),
            UINT64_C(0x000000000000),
            UINT64_C(0xFFFFFFFF38DBF9CB)
        }
    };

    const size_t test_count = sizeof(tests) / sizeof(tests[0]);
    size_t passed = 0;

    for (size_t t = 0; t < test_count; ++t) {
        uint64_t input = tests[t].input;
        uint64_t round_key = tests[t].round_key;
        uint64_t expected = tests[t].expected;

        printf("\n========== Test %zu ==========\n", t + 1);
        printf("Round input = %016" PRIX64 "\n", input);
        printf("Round key   = %012" PRIX64 "\n", round_key);
        printf("L0          = %08" PRIX32 "\n",
               (uint32_t)(input >> 32));
        printf("R0          = %08" PRIX32 "\n\n",
               (uint32_t)input);

        uint64_t output = des_round(input, round_key);

        printf("\nRound output (hex) = %016" PRIX64 "\n", output);
        printf("Expected     (hex) = %016" PRIX64 "\n", expected);

        printf("Round output (bin) = ");
        for (int i = 63; i >= 0; --i) {
            putchar(((output >> i) & UINT64_C(1)) ? '1' : '0');

            if (i % 8 == 0 && i != 0)
                putchar(' ');
        }
        putchar('\n');

        int success = (output == expected);
        passed += success;

        printf("Test               = %s\n",
               success ? "PASS" : "FAIL");
    }

    printf("\nPassed %zu of %zu tests.\n", passed, test_count);

    return passed == test_count ? 0 : 1;
}