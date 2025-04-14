/// The fraction of non-voters that will be added to the transfer option when the vote is finalized.
#define TRANSFER_FACTOR clamp((world.time / (1 MINUTES) - 120) / 240, 0, 1)
