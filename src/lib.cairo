use array::ArrayTrait;

const PAD_BYTE: u8 = '=';

struct GeneralPurpose {
    encode_table: Array<u8>,
    decode_table: Array<u8>,
}
