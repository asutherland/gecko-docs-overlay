## Key Classes

```searchfox-graph-v1
{
  "mode": "paths-between",
  "identifiers":
    [
      "SharedWorker::Constructor",
      "SendPSharedWorkerConstructor",
      "RecvPSharedWorkerConstructor",
      "SharedWorkerParent::Initialize",
      "SharedWorkerService::GetOrCreate",
      "SharedWorkerService::GetOrCreateWorkerManager",
      "GetOrCreateWorkerManagerRunnable",
      "SharedWorkerService::GetOrCreateWorkerManagerOnMainThread",
      "SharedWOrkerManager::Create"
    ]
}
```

- `SharedWorker`: DOM binding.  Holds a `SharedWorkerChild`.  Must exist on the main
  thread because we only allow top-level windows to create SharedWorkers.
- `SharedWorkerChild`: Held by `SharedWorker` bindings to remotely control
  sharedworker lifecycle and receive error and termination reports.
- `PSharedWorker`: Protocol for `SharedWorker` bindings to communicate with
  per-worker SharedWorkerManager instances in the parent via `SharedWorkerChild`/
  `SharedWorkerParent` and `SharedWorkerService` getting/creating the
  `SharedWorkerManager` if it doesn't already exist.  Main-thread to `PBackground`.
- `SharedWorkerParent`: `PBackground` actor that relays life-cycle events
  (freeze/thaw, suspend/resume, close) to the `PBackground` `SharedWorkerManager`
  and relays error/termination back to the child.
- `SharedWorkerService`: `PBackground` service that creates and tracks the
  per-worker SharedWorkerManager instances, allowing rendezvous between
  `SharedWorkerParent` instances and the `SharedWorkerManager`s they want to talk to
  (1:1).
- `SharedWorkerManager`: `PBackground` instance that corresponds to a single logical
  Shared Worker that exists somewhere in the process tree.  Referenced/owned by
  multiple `SharedWorkerParent` instances on the `PBackground` thread.  Holds/owns
  a single `RemoteWorkerController` to interact with the actual shared worker
  thread, wherever it is located.  Creates the `RemoteWorkerController` via
  `RemoteWorkerController::Create` which uses `RemoteWorkerManager::Launch` under
  the hood.
- `SharedWorkerManagerWrapper`: Holds a reference to a `SharedWorkerManagerHolder`
  that it ensures is released on the main-thread only.

## Starting a SharedWorker
