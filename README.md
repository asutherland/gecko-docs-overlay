This repository exists to support iterating on searchfox-enhanced gecko docs.

Long term, all the docs should just live in mozilla-central.

Directory structure:
- `docs/` - The actual documentation hierarchy, imitates mozilla-central's
  hierarchy.  Exists so we can have meta-documentation like this file and
  support scripts that don't get clobbered into the mozilla-central tree.

Note that this is not intended to be a generic overlay mechanism.  This is very
specific to mozilla-central and its searchfox indexing job.  In particular:
- The `config.json` is 100% specific to this case.
