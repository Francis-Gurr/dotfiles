# chezmoi TODO

## Firefox (extend `run_onchange_after_80-firefox.sh`)
- [x] **Spellcheck dictionaries in chezmoi:** en-GB + de-DE enabled together via
      `spellchecker.dictionary`. English ships with Firefox (system hunspell); German comes from
      the `hunspell-de` package. Personal dictionary (`persdict.dat`) — revisit once it has words.
- [x] **Never save passwords or payment cards** (Bitwarden is the store), via `user.js` prefs:
      `signon.rememberSignons`, `extensions.formautofill.creditCards.enabled`,
      `extensions.formautofill.addresses.enabled` all `false`. A `policies.json` hard-lock was
      considered but skipped (needs sudo + system-wide file).
