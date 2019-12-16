# ServiceWorkers

## Moving Parts
(and how they exist in the multi-process model.)

## How a navigation request is intercepted and mapped to a serviceworker.

```searchfox-graph-v1
{
  "mode": "paths-between",
  "identifiers":
    ["nsHttpChannel::Connect",
     "HttpBaseChannel::ShouldIntercept",
     "ServiceWorkerInterceptController::ShouldPrepareForIntercept",
     "ServiceWorkerManager::IsAvailable",
     "ServiceWorkerManager::GetServiceWorkerRegistrationInfo"]
}
```

## How a sub-resource request is mapped to a serviceworker.

## How a ServiceWorker is spawned.
(Call out to the RemoteWorker/SharedWorker documentation.)

## Non-Fetch events
How non-fetch events are dispatched to the serviceworker (including the IPC).

## Fetch events and FetchEvent.respondWith()
How fetch events are dispatched to the serviceworker and how the data-flow of respondWith works.
