use array::ArrayTrait;
use integer::BitAndBool;
use crate::PAD_BYTE;

const ALPHABET_SIZE: usize = 64;

#[derive(Drop)]
struct Alphabet {
    symbols: Array<u8>
}

/// Possible errors when constructing an [Alphabet] from a `Array`.
#[derive(Eq, PartialEq)]
enum ParseAlphabetError {
    /// Alphabets must be 64 ASCII bytes
    InvalidLength: (),
    /// All bytes must be unique
    DuplicatedByte: u8,
    /// All bytes must be printable (in the range `[32, 126]`).
    UnprintableByte: u8,
    /// `=` cannot be used
    ReservedByte: u8,
}

trait AlphabetTrait<Self> {
    fn new(chars: @Array<u8>) -> Result<Alphabet, ParseAlphabetError>;
}

impl AlphabetTraitImpl of AlphabetTrait<Self> {
    fn new(chars: @Array<u8>) -> Result<Alphabet, ParseAlphabetError> {
        if chars.len() != ALPHABET_SIZE {
            return Err(ParseAlphabetError::InvalidLength);
        }

        let mut index = 0;
        loop {
            if index >= ALPHABET_SIZE {
                break ();
            }

            let byte: u8 = chars.at(index);

            // Bitwise `and` for bool == logical `and` for bool
            if !(byte >= 32_u8 & byte <= 126_u8) {
                return Err(ParseAlphabetError::UnprintableByte(*byte));
            }
            if (byte == PAD_BYTE) {
                return Err(ParseAlphabetError::ReservedByte(*byte));
            }

            let mut probe_index = 0;
            loop {
                if probe_index >= ALPHABET_SIZE {
                    break ();
                }
                if probe_index == index {
                    probe_index += 1;
                    continue;
                }

                let probe_byte = bytes[probe_index];

                if byte == probe_byte {
                    return Err(ParseAlphabetError::DuplicatedByte(byte));
                }

                probe_index += 1;
            }

            index += 1;
        };

        Alphabet { symbols: chars }
    }
}


/// The standard alphabet (uses `+` and `/`).
///
/// See [RFC 3548](https://tools.ietf.org/html/rfc3548#section-3).
const STANDARD: Alphabet =
    {
        let array = ArrayTrait::new();
        array.append('A');
        array.append('B');
        array.append('C');
        array.append('D');
        array.append('E');
        array.append('F');
        array.append('G');
        array.append('H');
        array.append('I');
        array.append('J');
        array.append('K');
        array.append('L');
        array.append('M');
        array.append('N');
        array.append('O');
        array.append('P');
        array.append('Q');
        array.append('R');
        array.append('S');
        array.append('T');
        array.append('U');
        array.append('V');
        array.append('W');
        array.append('X');
        array.append('Y');
        array.append('Z');
        array.append('a');
        array.append('b');
        array.append('c');
        array.append('d');
        array.append('e');
        array.append('f');
        array.append('g');
        array.append('h');
        array.append('i');
        array.append('j');
        array.append('k');
        array.append('l');
        array.append('m');
        array.append('n');
        array.append('o');
        array.append('p');
        array.append('q');
        array.append('r');
        array.append('s');
        array.append('t');
        array.append('u');
        array.append('v');
        array.append('w');
        array.append('x');
        array.append('y');
        array.append('z');
        array.append('0');
        array.append('1');
        array.append('2');
        array.append('3');
        array.append('4');
        array.append('5');
        array.append('6');
        array.append('7');
        array.append('8');
        array.append('9');
        array.append('+');
        array.append('/');
        Alphabet::new(array)
    };

/// The URL safe alphabet (uses `-` and `_`).
///
/// See [RFC 3548](https://tools.ietf.org/html/rfc3548#section-4).
const URL_SAFE: Alphabet =
    {
        let array = ArrayTrait::new();
        array.append('A');
        array.append('B');
        array.append('C');
        array.append('D');
        array.append('E');
        array.append('F');
        array.append('G');
        array.append('H');
        array.append('I');
        array.append('J');
        array.append('K');
        array.append('L');
        array.append('M');
        array.append('N');
        array.append('O');
        array.append('P');
        array.append('Q');
        array.append('R');
        array.append('S');
        array.append('T');
        array.append('U');
        array.append('V');
        array.append('W');
        array.append('X');
        array.append('Y');
        array.append('Z');
        array.append('a');
        array.append('b');
        array.append('c');
        array.append('d');
        array.append('e');
        array.append('f');
        array.append('g');
        array.append('h');
        array.append('i');
        array.append('j');
        array.append('k');
        array.append('l');
        array.append('m');
        array.append('n');
        array.append('o');
        array.append('p');
        array.append('q');
        array.append('r');
        array.append('s');
        array.append('t');
        array.append('u');
        array.append('v');
        array.append('w');
        array.append('x');
        array.append('y');
        array.append('z');
        array.append('0');
        array.append('1');
        array.append('2');
        array.append('3');
        array.append('4');
        array.append('5');
        array.append('6');
        array.append('7');
        array.append('8');
        array.append('9');
        array.append('-');
        array.append('_');
        Alphabet::new(array)
    };
