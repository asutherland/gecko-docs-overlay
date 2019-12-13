## Classes

- RemoteWorkerController: PBackground instance created by static
  RemoteWorkerController::Create that builds on RemoteWorkerManager.  Interface
  to control the remote worker as well as receive events via the
  RemoteWorkerObserver interface that the owner (SharedWorkerManager in this
  case) must implement to hear about errors, termination, and whether the
  initial spawning succeeded/failed.  Its methods may be called immediately
  after creation even though the worker is created asynchronously; an internal
  operation queue makes this work.  Communicates with the remote worker via
  owned RemoteWorkerParent over PRemoteWorker protocol.
- RemoteWorkerManager: PBackground instance that keeps tracks of
  RemoteWorkerServiceParent actors (1 per process, including the main process)
  and pending RemoteWorkerController requests to spawn remote workers if the
  spawn request can't be immediately fulfilled.  Decides which
  RemoteWorkerServerParent to use internally via SelectTargetActor in order to
  select a BackgroundParent manager on which to create a RemoteWorkerParent.
- RemoteWorkerService: Every process has a RemoteWorkerService which does the
  actual spawning of RemoteWorkerChild instances.  The RemoteWorkerService
  creates a "Worker Launcher" thread at initialization on which it creates a
  RemoteWorkerServiceChild to service spawn requests.  The thread is exposed as
  RemoteWorkerService::Thread().  A new/distinct thread is used because we
  (eventually) don't want to deal with main-thread contention, content processes
  have no equivalent of a PBackground thread, and actors are bound to specific
  threads.  (Disclaimer: currently most RemoteWorkerOps need to happen on the
  main thread because the main-thread ends up as the owner of the worker and
  all manipulation of the worker must happen from the owning thread.)
- RemoteWorkerServiceChild: "Worker Launcher"-thread child actor created by the
  RemoteWorkerService to register itself with the PBackground
  RemoteWorkerManager in the parent.
- RemoteWorkerServiceParent: PBackground parent actor that registers with the
  PBackground RemoteWorkerManager and used to relay spawn requests.
- RemoteWorkerParent: PBackground-managed parent actor that is mutually
  associated with a single RemoteWorkerController.  Relays error/close events to
  the controller and in turns is told life-cycle events.
- RemoteWorkerChild: PBackground-managed "Worker Launcher"-thread-resident
  created via the RemoteWorkerManager to actually spawn the worker.  Currently,
  the worker will be spawned from the main thread due to nsIPrincipal not being
  able to be created on background threads and other ownership invariants, most
  of which can be relaxed in the future.

## Startup

## Consumers

### SharedWorkers

### ServiceWorkers

### Key Differences
