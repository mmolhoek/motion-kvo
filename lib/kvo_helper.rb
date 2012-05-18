module KVOHelper
  
  public
    def observe(target, key_path, &block)
      add_observer(target, key_path, &block)
      target.addObserver(self, forKeyPath:key_path, options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld, context:nil)
    end
      
    def unobserve(target, key_path)
      target.removeObserver(self, forKeyPath:key_path)
      remove_observer(target, key_path)
    end
  
    def remove_all_observers
      @observers.each do |key_path, observer|
        observers_for_key_path[:blocks].each do |observer|
          unobserve(observer[:target], key_path)
        end
      end
    end
    
  private
    def add_observer(target, key_path, &block)
      @observers = {} if @observers.nil?
      @observers[key_path] = [] if @observers[key_path].nil?
      @observers[key_path] << { target:target, block:block }
    end
    
    def remove_observer(target, key_path)
      @observers[key_path] = nil
    end
  
    # NSKeyValueObserving Protocol
    
  public
    def observeValueForKeyPath(key_path, ofObject:object, change:change, context:context)
      @observers[key_path].each do |observer|
        if !observer.nil? && observer[:target] == object && !observer[:block].nil?
          observer[:block].call(object, change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey])
        end
      end
    end
    
end
