// plugin-example-bootstrap's OWN self-contained CUE schema — the SINGLE SOURCE
// for this plugin's declaration surface, used two ways exactly like every other
// plugin's schema (there is no schema-less plugin):
//
//  1. GENERATE the Go params — `cue exp gengotypes` → ../params/cue_types_gen.go.
//  2. SERVE over Describe — the host splices `base ++ plugin` at the load gate
//     (registerPluginUnitSchema), so the plugin's declarations travel WITH it and
//     a self-contained schema that will not splice is a LOUD load failure.
//
// A bootstrap-phase plugin is invoked with the RAW project config bytes (the
// OpBootstrap `{config: string}` envelope), not a structured plugin_input, so it
// declares no InputDef — this schema DOCUMENTS the phase contract and satisfies
// the uniform non-empty-schema contract. SELF-CONTAINED: it references no base
// def, so it compiles STANDALONE (the property `cue exp gengotypes` needs and the
// property that lets the SDK compile it serve-side).
#ExampleBootstrapPlugin: {
	// The verb word the plugin serves.
	verb: "examplebootstrap"

	// The lifecycle phase the provider is invoked in.
	phase: "bootstrap"

	// What the plugin does, in one line (the public-docs surface).
	contract: string & !=""

	// The configuration surface: env var names the bootstrap transform reads.
	config?: [string]: string
}
