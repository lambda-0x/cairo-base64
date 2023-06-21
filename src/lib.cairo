mod alphabet;
mod engine;

use array::ArrayTrait;
use clone::Clone;
use alphabet::Alphabet;
use engine::{Engine, Config, DecodeEstimate};

const PAD_BYTE: u8 = '=';

struct GeneralPurpose {
    encode_table: Array<u8>,
    decode_table: Array<u8>,
    config: GeneralPurposeConfig,
}

trait GeneralPurposeTrait<T> {
    fn new(alphabet: @Alphabet, config: GeneralPurposeConfig) -> T;
}

impl GeneralPurposeTraitImpl of GeneralPurposeTrait<GeneralPurpose> {
    fn new(alphabet: @Alphabet, config: GeneralPurposeConfig) -> GeneralPurpose {
        GeneralPurpose {
            encode_table: encode_table(alphabet), decode_table: decode_table(alphabet), config, 
        }
    }
}

#[derive(Debug, Clone, Drop)]
struct GeneralPurposeConfig {
    encode_padding: bool,
    decode_allow_trailing_bits: bool,
}


/// Returns a table mapping a 6-bit index to the ASCII byte encoding of the index
fn encode_table(alphabet: @Alphabet) -> Array<u8> {
    // the encode table is just the alphabet:
    // 6-bit index lookup -> printable byte
    let mut encode_table: Array<u8> = ArrayTrait::new();
    {
        let mut index = 0;
        loop {
            if !(index < 64) {
                break ();
            }
            encode_table.append(*alphabet.symbols[index]);
            index += 1;
        }
    }

    encode_table
}


/// Returns a table mapping base64 bytes as the lookup index to either:
/// - [INVALID_VALUE] for bytes that aren't members of the alphabet
/// - a byte whose lower 6 bits are the value that was encoded into the index byte
fn decode_table(alphabet: @Alphabet) -> Array<u8> {
    let mut decode_table: Array<u8> = ArrayTrait::new();

    // Since the table is full of `INVALID_VALUE` already, we only need to overwrite
    // the parts that are valid.
    let mut index: usize = 0;
    loop {
        if !(index < 64) {
            break ();
        }
        // The index in the alphabet is the 6-bit value we care about.
        // Since the index is in 0-63, it is safe to cast to u8.

        // decode_table[alphabet.symbols[index] as usize] = index as u8;
        index += 1;
    };

    decode_table
}
