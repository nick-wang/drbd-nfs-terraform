base:
  '*':
    - default

  'role:drbd':
    - match: grain
    - drbd

  'drbdnfs:cluster':
    - match: grain
    - cluster
