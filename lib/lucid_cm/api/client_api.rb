module LucidCM
  class ClientAPI

    include LucidClient::API

    def all( params = {} )
      params = _default_params.merge( params )
      r      = session.get_resource( 'clients', params  )

      represent_each r
    end

    private

    def _model
      callable LucidCM.config[:client_model]
    end

  end
end
