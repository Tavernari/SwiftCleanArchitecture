//
// Created by Victor C Tavernari on 28/04/20.
// Copyright (c) 2020 Taverna Apps. All rights reserved.
//

import DomainLayer

extension GitRepoReliabilityMultiplierModel {
    init(remoteConfigData: FlagableConfig<RepoReliabilityConfigDTO>) {
        self.init()
        enable = remoteConfigData.enable
        multiplier = remoteConfigData.data.multiplier
    }
}
