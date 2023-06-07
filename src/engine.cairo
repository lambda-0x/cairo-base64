trait Engine<
    Self,
    ConfigType,
    DecodeEstimateType,
    impl TConfig: Config<ConfigType>,
    impl TDecodeEstimate: DecodeEstimate<DecodeEstimateType>
> {
    // Required method
    fn config(self: @Self) -> ConfigType;

    // Provided methods
    fn encode(data: @Array<u8>) -> Array<u8>;
    fn decode(data: @Array<u8>) -> Array<u8>;
}

trait Config<Self> {
    fn encode_padding(self: Self) -> bool;
}

trait DecodeEstimate<Self> {
    fn decoded_len_estimate(self: Self) -> usize;
}
